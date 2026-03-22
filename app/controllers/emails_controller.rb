class EmailsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:unsubscribe]

  def send_single
    contact        = Contact.where({ :id => params.fetch("query_contact_id") }).at(0)
    email_template = EmailTemplate.where({ :id => params.fetch("query_email_template_id") }).at(0)

    unless current_user.smtp_configured?
      redirect_to("/contacts/#{contact.id}", { :alert => "Please configure your SMTP settings in your profile first." })
      return
    end

    if contact.unsubscribed == true || contact.email_consent == false
      redirect_to("/contacts/#{contact.id}", { :alert => "Cannot send: this contact has unsubscribed or not given email consent." })
      return
    end

    rendered = email_template.render_for(contact, current_user)

    email_send = EmailSend.new
    email_send.contact_id        = contact.id
    email_send.email_template_id = email_template.id
    email_send.user_id           = current_user.id
    email_send.subject           = rendered[:subject]
    email_send.body              = rendered[:body]

    begin
      OutreachMailer.send_outreach(contact, rendered, current_user).deliver_now
      email_send.status = "sent"
      email_send.save

      outreach                   = Outreach.new
      outreach.contact_id        = contact.id
      outreach.outreach_datetime = Time.now
      outreach.outreach_medium   = "Email"
      outreach.rep_id            = current_user.id
      outreach.notes             = "Email sent: #{email_template.name}"
      outreach.save

      redirect_to("/contacts/#{contact.id}", { :notice => "Email sent to #{contact.email}." })
    rescue => e
      email_send.status = "failed"
      email_send.save
      redirect_to("/contacts/#{contact.id}", { :alert => "Failed to send email: #{e.message}" })
    end
  end

  def send_bulk
    the_list       = List.where({ :id => params.fetch("query_list_id") }).at(0)
    email_template = EmailTemplate.where({ :id => params.fetch("query_email_template_id") }).at(0)

    unless current_user.smtp_configured?
      redirect_to("/lists/#{the_list.id}", { :alert => "Please configure your SMTP settings in your profile first." })
      return
    end

    sent_count         = 0
    failed_count       = 0
    skipped_no_email   = 0
    skipped_unsub      = 0

    the_list.all_companies.each do |company|
      contacts_with_email = company.contacts.where.not(:email => [nil, ""])

      if contacts_with_email.empty?
        skipped_no_email += 1
        next
      end

      contacts_with_email.each do |contact|
        if contact.unsubscribed == true || contact.email_consent == false
          skipped_unsub += 1
          next
        end
        rendered = email_template.render_for(contact, current_user)

        email_send                 = EmailSend.new
        email_send.contact_id        = contact.id
        email_send.email_template_id = email_template.id
        email_send.user_id           = current_user.id
        email_send.subject           = rendered[:subject]
        email_send.body              = rendered[:body]

        begin
          OutreachMailer.send_outreach(contact, rendered, current_user).deliver_now
          email_send.status = "sent"
          email_send.save

          outreach                   = Outreach.new
          outreach.contact_id        = contact.id
          outreach.outreach_datetime = Time.now
          outreach.outreach_medium   = "Email"
          outreach.rep_id            = current_user.id
          outreach.notes             = "Email sent: #{email_template.name}"
          outreach.save

          sent_count += 1
          sleep(3)
        rescue => e
          email_send.status = "failed"
          email_send.save
          failed_count += 1
        end
      end
    end

    notice = "Sent #{sent_count} #{"email".pluralize(sent_count)}."
    notice += " #{skipped_no_email} skipped (no email)." if skipped_no_email > 0
    notice += " #{skipped_unsub} skipped (unsubscribed)." if skipped_unsub > 0
    notice += " #{failed_count} failed." if failed_count > 0

    redirect_to("/lists/#{the_list.id}", { :notice => notice })
  end

  def unsubscribe
    the_id  = params.fetch("path_id")
    contact = Contact.where({ :id => the_id }).at(0)

    contact.unsubscribed      = true
    contact.unsubscribed_date = Time.now
    contact.save

    render({ :template => "email_templates/unsubscribe", :layout => "application" })
  end
end
