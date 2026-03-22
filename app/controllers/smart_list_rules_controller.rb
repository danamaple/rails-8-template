class SmartListRulesController < ApplicationController
  def index
    matching_smart_list_rules = SmartListRule.all

    @list_of_smart_list_rules = matching_smart_list_rules.order({ :created_at => :desc })

    render({ :template => "smart_list_rule_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_smart_list_rules = SmartListRule.where({ :id => the_id })

    @the_smart_list_rule = matching_smart_list_rules.at(0)

    render({ :template => "smart_list_rule_templates/show" })
  end

  def create
    the_smart_list_rule = SmartListRule.new
    the_smart_list_rule.list_id = params.fetch("query_list_id")
    the_smart_list_rule.field = params.fetch("query_field")
    the_smart_list_rule.measurement = params.fetch("query_measurement")
    the_smart_list_rule.value = params.fetch("query_value", "")

    if the_smart_list_rule.valid?
      the_smart_list_rule.save
      redirect_to("/lists/#{the_smart_list_rule.list_id}", { :notice => "Rule added successfully." })
    else
      redirect_to("/lists/#{the_smart_list_rule.list_id}", { :alert => the_smart_list_rule.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_smart_list_rule = SmartListRule.where({ :id => the_id }).at(0)

    the_smart_list_rule.list_id = params.fetch("query_list_id")
    the_smart_list_rule.field = params.fetch("query_field")
    the_smart_list_rule.measurement = params.fetch("query_measurement")
    the_smart_list_rule.value = params.fetch("query_value")

    if the_smart_list_rule.valid?
      the_smart_list_rule.save
      redirect_to("/smart_list_rules/#{the_smart_list_rule.id}", { :notice => "Smart list rule updated successfully." } )
    else
      redirect_to("/smart_list_rules/#{the_smart_list_rule.id}", { :alert => the_smart_list_rule.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_smart_list_rule = SmartListRule.where({ :id => the_id }).at(0)

    list_id = the_smart_list_rule.list_id
    the_smart_list_rule.destroy

    redirect_to("/lists/#{list_id}", { :notice => "Rule removed successfully." })
  end
end
