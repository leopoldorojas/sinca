class QueriesController < ApplicationController
  def new
  	@query = Query.new
  end

  def create
    @query = Query.new(query_params)
    @average = Indicator.by_date_range(@query).average(:indicator_1)
    @sum = Indicator.by_date_range(@query).sum(:indicator_1)
    @count = Indicator.by_date_range(@query).count

    respond_to do |format|
      format.html { render :new }
      format.json { render json: { average: @average, sum: @sum, count: @count, text: "El promedio es #{@average || 'incalculable'} y la suma es #{@sum} con #{@count} empresas contabilizadas" }, status: :ok }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:start_date, :end_date)
    end

end
