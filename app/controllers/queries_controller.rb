class QueriesController < ApplicationController
  
  def new
  	@query = Query.new(end_date: Date.current, type: :all, location: nil, companies: [], executive: nil)
    authorize @query
    @all_indicators = Rails.application.config.individual_indicators
  end

  def create
    @query = Query.new(query_params)
    authorize @query
    @query.companies = [current_user.credit_company.id] if policy(CreditCompany).see_only_own_company?
    @query.run

    respond_to do |format|
      format.html { render :new }
      format.json { render json: @query }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:end_date, :type, :location, { :companies => [] }, :executive)
    end

end
