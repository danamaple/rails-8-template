class EmailProductRulesController < ApplicationController
  def index
    matching_email_product_rules = EmailProductRule.all

    @list_of_email_product_rules = matching_email_product_rules.order({ :created_at => :desc })

    render({ :template => "email_product_rule_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_email_product_rules = EmailProductRule.where({ :id => the_id })

    @the_email_product_rule = matching_email_product_rules.at(0)

    render({ :template => "email_product_rule_templates/show" })
  end

  def create
    the_email_product_rule = EmailProductRule.new
    the_email_product_rule.email_template_id = params.fetch("query_email_template_id")
    the_email_product_rule.field = params.fetch("query_field")
    the_email_product_rule.measurement = params.fetch("query_measurement")
    the_email_product_rule.value = params.fetch("query_value")

    if the_email_product_rule.valid?
      the_email_product_rule.save
      redirect_to("/email_templates/#{the_email_product_rule.email_template_id}", { :notice => "Rule added." })
    else
      redirect_to("/email_templates/#{the_email_product_rule.email_template_id}", { :alert => the_email_product_rule.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_email_product_rule = EmailProductRule.where({ :id => the_id }).at(0)

    the_email_product_rule.email_template_id = params.fetch("query_email_template_id")
    the_email_product_rule.field = params.fetch("query_field")
    the_email_product_rule.measurement = params.fetch("query_measurement")
    the_email_product_rule.value = params.fetch("query_value")

    if the_email_product_rule.valid?
      the_email_product_rule.save
      redirect_to("/email_product_rules/#{the_email_product_rule.id}", { :notice => "Email product rule updated successfully." } )
    else
      redirect_to("/email_product_rules/#{the_email_product_rule.id}", { :alert => the_email_product_rule.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_email_product_rule = EmailProductRule.where({ :id => the_id }).at(0)

    the_email_template_id = the_email_product_rule.email_template_id
    the_email_product_rule.destroy

    redirect_to("/email_templates/#{the_email_template_id}", { :notice => "Rule removed." })
  end
end
