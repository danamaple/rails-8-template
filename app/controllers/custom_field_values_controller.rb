class CustomFieldValuesController < ApplicationController
  def index
    matching_custom_field_values = CustomFieldValue.all

    @list_of_custom_field_values = matching_custom_field_values.order({ :created_at => :desc })

    render({ :template => "custom_field_value_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_custom_field_values = CustomFieldValue.where({ :id => the_id })

    @the_custom_field_value = matching_custom_field_values.at(0)

    render({ :template => "custom_field_value_templates/show" })
  end

  def create
    the_custom_field_value = CustomFieldValue.new
    the_custom_field_value.product_id = params.fetch("query_product_id")
    the_custom_field_value.custom_field_id = params.fetch("query_custom_field_id")
    the_custom_field_value.value = params.fetch("query_value", "")

    if the_custom_field_value.valid?
      the_custom_field_value.save
      redirect_to("/products/#{the_custom_field_value.product_id}", { :notice => "Custom field value saved." })
    else
      redirect_to("/products/#{the_custom_field_value.product_id}", { :alert => the_custom_field_value.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_custom_field_value = CustomFieldValue.where({ :id => the_id }).at(0)

    the_custom_field_value.value = params.fetch("query_value", "")

    if the_custom_field_value.valid?
      the_custom_field_value.save
      redirect_to("/products/#{the_custom_field_value.product_id}", { :notice => "Custom field value updated." })
    else
      redirect_to("/products/#{the_custom_field_value.product_id}", { :alert => the_custom_field_value.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_custom_field_value = CustomFieldValue.where({ :id => the_id }).at(0)

    the_custom_field_value.destroy

    redirect_to("/custom_field_values", { :notice => "Custom field value deleted successfully." } )
  end
end
