class ContactsController < ApplicationController
  def index
    matching_contacts = Contact.all

    if params["query_search"].present?
      term = "%#{params["query_search"]}%"
      matching_contacts = matching_contacts.where(
        "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", term, term, term
      )
    end

    if params["query_company_id"].present?
      matching_contacts = matching_contacts.where({ :company_id => params["query_company_id"] })
    end

    if params["query_general_company_contact"].present?
      matching_contacts = matching_contacts.where({ :general_company_contact => params["query_general_company_contact"] == "true" })
    end

    @total_count = Contact.count
    @filtered_count = matching_contacts.count
    @list_of_contacts = matching_contacts.includes(:company).order({ :last_name => :asc })
    @list_of_companies = Company.all.order({ :company_name => :asc })

    render({ :template => "contact_templates/index" })
  end

  def new
    @list_of_companies = Company.all.order({ :company_name => :asc })

    render({ :template => "contact_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_contacts = Contact.where({ :id => the_id })
    @the_contact = matching_contacts.at(0)
    @list_of_email_templates = EmailTemplate.all.order({ :name => :asc })

    render({ :template => "contact_templates/show" })
  end

  def create
    the_contact = Contact.new
    the_contact.company_id = params.fetch("query_company_id")
    the_contact.first_name = params.fetch("query_first_name", "")
    the_contact.last_name = params.fetch("query_last_name", "")
    the_contact.preferred_name = params.fetch("query_preferred_name", "")
    the_contact.title = params.fetch("query_title", "")
    the_contact.email = params.fetch("query_email", "")
    the_contact.phone = params.fetch("query_phone", "")
    the_contact.linkedin = params.fetch("query_linkedin", "")
    the_contact.notes = params.fetch("query_notes", "")
    the_contact.general_company_contact = params.fetch("query_general_company_contact", false)
    the_contact.email_consent = params.fetch("query_email_consent", false)

    if the_contact.valid?
      the_contact.save
      redirect_to("/companies/#{the_contact.company_id}", { :notice => "Contact created successfully." })
    else
      redirect_to("/companies/#{the_contact.company_id}", { :alert => the_contact.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_contact = Contact.where({ :id => the_id }).at(0)

    the_contact.company_id = params.fetch("query_company_id")
    the_contact.first_name = params.fetch("query_first_name", "")
    the_contact.last_name = params.fetch("query_last_name", "")
    the_contact.preferred_name = params.fetch("query_preferred_name", "")
    the_contact.title = params.fetch("query_title", "")
    the_contact.email = params.fetch("query_email", "")
    the_contact.phone = params.fetch("query_phone", "")
    the_contact.linkedin = params.fetch("query_linkedin", "")
    the_contact.notes = params.fetch("query_notes", "")
    the_contact.general_company_contact = params.fetch("query_general_company_contact", false)
    the_contact.email_consent = params.fetch("query_email_consent", false)

    if the_contact.valid?
      the_contact.save
      redirect_to("/contacts/#{the_contact.id}", { :notice => "Contact updated successfully." })
    else
      redirect_to("/contacts/#{the_contact.id}", { :alert => the_contact.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_contact = Contact.where({ :id => the_id }).at(0)
    the_company_id = the_contact.company_id

    the_contact.destroy

    redirect_to("/companies/#{the_company_id}", { :notice => "Contact deleted successfully." })
  end

  def export
    matching_contacts = Contact.all

    if params["query_search"].present?
      term = "%#{params["query_search"]}%"
      matching_contacts = matching_contacts.where(
        "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", term, term, term
      )
    end

    if params["query_company_id"].present?
      matching_contacts = matching_contacts.where({ :company_id => params["query_company_id"] })
    end

    if params["query_general_company_contact"].present?
      matching_contacts = matching_contacts.where({ :general_company_contact => params["query_general_company_contact"] == "true" })
    end

    matching_contacts = matching_contacts.includes(:company).order({ :last_name => :asc })

    respond_to do |format|
      format.csv do
        send_data(Contact.to_csv(matching_contacts), { :filename => "contacts-#{Date.today}.csv" })
      end
    end
  end
end
