class CustomFieldsController < ApplicationController
  def index
    matching_custom_fields = CustomField.all

    @list_of_custom_fields = matching_custom_fields.order({ :created_at => :desc })

    render({ :template => "custom_field_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_custom_fields = CustomField.where({ :id => the_id })

    @the_custom_field = matching_custom_fields.at(0)

    render({ :template => "custom_field_templates/show" })
  end

  def create
    the_custom_field = CustomField.new
    the_custom_field.field_name = params.fetch("query_field_name")
    the_custom_field.data_type = params.fetch("query_data_type")

    if the_custom_field.valid?
      the_custom_field.save
      redirect_to("/custom_fields", { :notice => "Custom field created successfully." })
    else
      redirect_to("/custom_fields", { :alert => the_custom_field.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_custom_field = CustomField.where({ :id => the_id }).at(0)

    the_custom_field.field_name = params.fetch("query_field_name")
    the_custom_field.data_type = params.fetch("query_data_type")

    if the_custom_field.valid?
      the_custom_field.save
      redirect_to("/custom_fields/#{the_custom_field.id}", { :notice => "Custom field updated successfully." } )
    else
      redirect_to("/custom_fields/#{the_custom_field.id}", { :alert => the_custom_field.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_custom_field = CustomField.where({ :id => the_id }).at(0)

    the_custom_field.destroy

    redirect_to("/custom_fields", { :notice => "Custom field deleted successfully." } )
  end
end
