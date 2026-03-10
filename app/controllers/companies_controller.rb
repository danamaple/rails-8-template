class CompaniesController < ApplicationController
  def index
    matching_companies = Company.all

    if params["query_search"].present?
      matching_companies = matching_companies.where("company_name ILIKE ?", "%#{params["query_search"]}%")
    end

    if params["query_status"].present?
      matching_companies = matching_companies.where({ :status => params["query_status"] })
    end

    if params["query_category_id"].present?
      matching_companies = matching_companies.joins(:portfolios).where(portfolios: { category_id: params["query_category_id"] }).distinct
    end

    @total_count = Company.count
    @filtered_count = matching_companies.count
    @list_of_companies = matching_companies.includes(portfolios: :category).order({ :company_name => :asc })
    @list_of_categories = Category.all.order({ :category => :asc })

    # Outreach aggregate stats — one query for all counts + max date
    @outreach_stats = Outreach.joins(:contact)
      .group("contacts.company_id")
      .select(
        "contacts.company_id",
        "COUNT(*) AS total_outreaches",
        "COUNT(CASE WHEN outreach_medium = 'Call'   THEN 1 END) AS phone_count",
        "COUNT(CASE WHEN outreach_medium = 'Email'  THEN 1 END) AS email_count",
        "COUNT(CASE WHEN outreach_medium = 'Letter' THEN 1 END) AS letter_count",
        "MAX(outreach_datetime) AS most_recent_date"
      )
      .index_by { |r| r.company_id.to_i }

    # Most recent outreach per company — one query using DISTINCT ON (PostgreSQL)
    @recent_outreaches = Outreach
      .joins(:contact, :rep)
      .where("outreach_datetime IS NOT NULL")
      .select(
        "DISTINCT ON (contacts.company_id) contacts.company_id",
        "users.first_name || ' ' || users.last_name AS rep_name",
        "outreaches.outreach_medium AS recent_medium"
      )
      .order("contacts.company_id, outreaches.outreach_datetime DESC")
      .index_by { |r| r.company_id.to_i }

    render({ :template => "company_templates/index" })
  end

  def new
    render({ :template => "company_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_companies = Company.where({ :id => the_id })

    @the_company = matching_companies.at(0)

    @list_of_categories = Category.all.order({ :category => :asc })

    render({ :template => "company_templates/show" })
  end

  def create
    the_company = Company.new
    the_company.company_name = params.fetch("query_company_name")
    the_company.website = params.fetch("query_website")
    the_company.status = params.fetch("query_status")
    the_company.notes = params.fetch("query_notes")

    if the_company.valid?
      the_company.save
      redirect_to("/companies/#{the_company.id}", { :notice => "Company created successfully." })
    else
      redirect_to("/companies", { :alert => the_company.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_company = Company.where({ :id => the_id }).at(0)

    the_company.company_name = params.fetch("query_company_name")
    the_company.website = params.fetch("query_website")
    the_company.status = params.fetch("query_status")
    the_company.notes = params.fetch("query_notes")

    if the_company.valid?
      the_company.save
      redirect_to("/companies/#{the_company.id}", { :notice => "Company updated successfully." })
    else
      redirect_to("/companies/#{the_company.id}", { :alert => the_company.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_company = Company.where({ :id => the_id }).at(0)

    the_company.destroy

    redirect_to("/companies", { :notice => "Company deleted successfully." })
  end
end
