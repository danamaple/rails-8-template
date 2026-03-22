class OutreachMailer < ApplicationMailer
  def send_outreach(contact, rendered_email, sender)
    delivery_options = {
      :address              => sender.smtp_address,
      :port                 => sender.smtp_port || 587,
      :user_name            => sender.smtp_username,
      :password             => sender.smtp_password,
      :authentication       => "plain",
      :enable_starttls_auto => true
    }

    app_url = ENV.fetch("APP_URL", "http://localhost:3000")
    unsubscribe_url = "#{app_url}/unsubscribe/#{contact.id}"
    body_with_footer = "#{rendered_email[:body]}\n\n---\nTo unsubscribe, visit: #{unsubscribe_url}"

    mail(
      :to                       => contact.email,
      :from                     => sender.smtp_from_email || sender.email,
      :subject                  => rendered_email[:subject],
      :body                     => body_with_footer,
      :delivery_method_options  => delivery_options
    )
  end
end
