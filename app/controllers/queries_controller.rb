class QueriesController < ApplicationController
  def new
  	@query = Query.new
  end

  def create
    @query = Query.new(query_params)
    result = Result.new
    result.tap do |r|
      r.name = :indicator_1
      r.average = Indicator.by_date_range(@query).average(:indicator_1)
      r.sum = Indicator.by_date_range(@query).sum(:indicator_1)
      r.count = Indicator.by_date_range(@query).count(:indicator_1)
    end

    result2 = Result.new
    result2.tap do |r|
      r.name = :indicator_2
      r.average = Indicator.by_date_range(@query).average(:indicator_2)
      r.sum = Indicator.by_date_range(@query).sum(:indicator_2)
      r.count = Indicator.by_date_range(@query).count(:indicator_2)
    end

    result3 = Result.new
    result3.tap do |r|
      r.name = :indicator_1
      r.average = Indicator.by_date_range(@query).average(:indicator_3)
      r.sum = Indicator.by_date_range(@query).sum(:indicator_3)
      r.count = Indicator.by_date_range(@query).count(:indicator_3)
    end

    @query.results = [result, result2, result3]

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
