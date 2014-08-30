class QueriesController < ApplicationController
  def new
  	@query = Query.new
  end

  def create
    @query = Query.new(query_params)
    @result = Result.new(
      name: :indicator_1, 
      average: Indicator.by_date_range(@query).average(:indicator_1),
      sum: Indicator.by_date_range(@query).sum(:indicator_1),
      count: Indicator.by_date_range(@query).count(:indicator_1),
      query: @query
    )

    respond_to do |format|
      format.html { render :new }
      format.json { render json: { result: @result }, status: :ok }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:start_date, :end_date)
    end

end
