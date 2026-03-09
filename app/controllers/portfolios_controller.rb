class PortfoliosController < ApplicationController
  def index
    matching_portfolios = Portfolio.all

    @list_of_portfolios = matching_portfolios.order({ :created_at => :desc })

    render({ :template => "portfolio_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_portfolios = Portfolio.where({ :id => the_id })

    @the_portfolio = matching_portfolios.at(0)

    render({ :template => "portfolio_templates/show" })
  end

  def create
    the_portfolio = Portfolio.new
    the_portfolio.company_id = params.fetch("query_company_id")
    the_portfolio.category_id = params.fetch("query_category_id")

    if the_portfolio.valid?
      the_portfolio.save
      redirect_to("/companies/#{the_portfolio.company_id}", { :notice => "Category added successfully." })
    else
      redirect_to("/companies/#{the_portfolio.company_id}", { :alert => the_portfolio.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_id }).at(0)

    the_portfolio.company_id = params.fetch("query_company_id")
    the_portfolio.category_id = params.fetch("query_category_id")

    if the_portfolio.valid?
      the_portfolio.save
      redirect_to("/portfolios/#{the_portfolio.id}", { :notice => "Portfolio updated successfully." })
    else
      redirect_to("/portfolios/#{the_portfolio.id}", { :alert => the_portfolio.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_id }).at(0)
    the_company_id = the_portfolio.company_id

    the_portfolio.destroy

    redirect_to("/companies/#{the_company_id}", { :notice => "Category removed successfully." })
  end
end
