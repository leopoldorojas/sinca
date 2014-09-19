class QueriesController < ApplicationController
  
  def new
  	@query = Query.new(start_date: Date.current.at_beginning_of_month, end_date: Date.current)
    @all_indicators = Rails.application.config.individual_indicators
  end

  def create
    @query = Query.new(query_params)
    @query.execute

    respond_to do |format|
      format.html { render :new }
      format.json { render json: @query }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:start_date, :end_date)
    end

end
