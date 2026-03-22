class EmailSendsController < ApplicationController
  def index
    matching = EmailSend.includes({ :contact => :company }, :email_template, :user)

    if params["query_email_template_id"].present?
      matching = matching.where({ :email_template_id => params["query_email_template_id"] })
    end

    if params["query_user_id"].present?
      matching = matching.where({ :user_id => params["query_user_id"] })
    end

    if params["query_status"].present?
      matching = matching.where({ :status => params["query_status"] })
    end

    if params["query_date_from"].present?
      matching = matching.where("email_sends.created_at >= ?", params["query_date_from"].to_date.beginning_of_day)
    end

    if params["query_date_to"].present?
      matching = matching.where("email_sends.created_at <= ?", params["query_date_to"].to_date.end_of_day)
    end

    @total_count             = EmailSend.count
    @filtered_count          = matching.count
    @list_of_email_sends     = matching.order({ :created_at => :desc })
    @list_of_email_templates = EmailTemplate.all.order({ :name => :asc })
    @list_of_users           = User.all.order({ :last_name => :asc, :first_name => :asc })

    render({ :template => "email_send_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_email_send = EmailSend.includes({ :contact => :company }, :email_template, :user)
                               .where({ :id => the_id }).at(0)

    render({ :template => "email_send_templates/show" })
  end

  def export
    sends = EmailSend.includes({ :contact => :company }, :email_template, :user).order({ :created_at => :desc })

    headers = ["id", "date_sent", "contact_name", "company", "template", "subject", "status", "sent_by"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      sends.each do |s|
        csv << [
          s.id,
          s.created_at&.strftime("%Y-%m-%d %H:%M"),
          "#{s.contact&.first_name} #{s.contact&.last_name}".strip,
          s.contact&.company&.company_name,
          s.email_template&.name,
          s.subject,
          s.status,
          "#{s.user&.first_name} #{s.user&.last_name}".strip
        ]
      end
    end

    respond_to do |format|
      format.csv do
        send_data(csv, { :filename => "email-sends-#{Date.today}.csv" })
      end
    end
  end
end
