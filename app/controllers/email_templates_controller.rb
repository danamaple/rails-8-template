class EmailTemplatesController < ApplicationController
  def index
    matching_email_templates = EmailTemplate.all

    if params["query_name"].present?
      matching_email_templates = matching_email_templates.where("name ILIKE ?", "%#{params["query_name"]}%")
    end

    @list_of_email_templates = matching_email_templates.order({ :name => :asc })

    render({ :template => "email_template_templates/index" })
  end

  def new
    render({ :template => "email_template_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_email_template = EmailTemplate.where({ :id => the_id }).at(0)
    @list_of_all_contacts = Contact.all.order({ :last_name => :asc, :first_name => :asc })
    @list_of_all_products = Product.where({ :is_active => true }).order({ :name => :asc })
    @template_products = @the_email_template.email_template_products.includes(:product => :brand).order(:position)
    @product_rules = @the_email_template.email_product_rules.order(:created_at)
    @rule_matched_count = @the_email_template.rule_matched_products.count
    @list_of_brands = Brand.order(:name)
    @list_of_suppliers = Supplier.order(:name)
    @list_of_category_ones = ProductCategoryOne.order(:name)
    @list_of_category_twos = ProductCategoryTwo.order(:name)

    if params["preview_contact_id"].present?
      preview_contact = Contact.where({ :id => params["preview_contact_id"] }).at(0)
      @preview = @the_email_template.render_for(preview_contact, current_user)
      @preview_contact = preview_contact
    end

    render({ :template => "email_template_templates/show" })
  end

  def create
    the_email_template = EmailTemplate.new
    the_email_template.name    = params.fetch("query_name")
    the_email_template.subject = params.fetch("query_subject")
    the_email_template.body    = params.fetch("query_body")

    if the_email_template.valid?
      the_email_template.save
      redirect_to("/email_templates/#{the_email_template.id}", { :notice => "Email template created successfully." })
    else
      redirect_to("/email_templates/new", { :alert => the_email_template.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_email_template = EmailTemplate.where({ :id => the_id }).at(0)

    the_email_template.name = params.fetch("query_name")
    the_email_template.subject = params.fetch("query_subject")
    the_email_template.body = params.fetch("query_body")
    the_email_template.show_prices = params.fetch("query_show_prices", "false") == "true"

    if the_email_template.valid?
      the_email_template.save
      redirect_to("/email_templates/#{the_email_template.id}", { :notice => "Email template updated successfully." } )
    else
      redirect_to("/email_templates/#{the_email_template.id}", { :alert => the_email_template.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_email_template = EmailTemplate.where({ :id => the_id }).at(0)

    the_email_template.destroy

    redirect_to("/email_templates", { :notice => "Email template deleted successfully." })
  end

  def export
    templates = EmailTemplate.all.order({ :name => :asc })

    respond_to do |format|
      format.csv do
        send_data(EmailTemplate.to_csv(templates), { :filename => "email-templates-#{Date.today}.csv" })
      end
    end
  end
end
