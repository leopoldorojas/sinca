class IndicatorsController < ApplicationController
  before_action :set_indicator, only: [:show, :edit, :update, :destroy]

  # GET /indicators
  # GET /indicators.json
  def index
    @indicators = policy_scope(Indicator).order(register_date: :desc).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data @indicators.to_csv }
      format.xls #{ send_data @indicators.to_csv(col_sep: "\t") }
    end
  end

  # GET /indicators/1
  # GET /indicators/1.json
  def show
  end

  # GET /indicators/new
  def new
    @indicator = Indicator.new
  end

  # GET /indicators/upload
  def upload
    @indicator = Indicator.new
    authorize @indicator
  end

  # GET /indicators/1/edit
  def edit
    authorize @indicator
    @readonly = policy(@indicator).block_allowed_fields?
  end

  # POST /indicators
  # POST /indicators.json
  def create
    @indicator = Indicator.new(indicator_params)
    authorize @indicator

    respond_to do |format|
      if @indicator.save
        format.html { redirect_to @indicator, notice: t('indicator.created') }
        format.json { render :show, status: :created, location: @indicator }
      else
        format.html { render :new }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /receive_and_create
  def receive_and_create
    if params.try(:[], :indicator).try(:[], :file_name)
      if (@indicator = Indicator.new(indicator_params)).valid?
        @indicator = Indicator.import(current_user.credit_company, params[:indicator][:file_name])
        @indicator.persisted? ? redirect_to(@indicator, notice: t('indicator.uploaded')) : render(:upload)
      else
        render :upload
      end
    else
      @indicator = Indicator.new
      @indicator.errors[:file_name] = t('indicator.empty_file_name')
      render :upload
    end
  end

  # PATCH/PUT /indicators/1
  # PATCH/PUT /indicators/1.json
  def update
    respond_to do |format|
      if @indicator.update(indicator_params)
        format.html { redirect_to @indicator, notice: t('indicator.updated') }
        format.json { render :show, status: :ok, location: @indicator }
      else
        format.html { render :edit }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicators/1
  # DELETE /indicators/1.json
  def destroy
    authorize @indicator
    @indicator.destroy
    respond_to do |format|
      format.html { redirect_to indicators_url, notice: t('indicator.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def indicator_params
      params.require(:indicator).permit(:register_date, :credit_company_id, :file_name, :indicator_1, :indicator_2, :indicator_3, :indicator_4, :indicator_5, :indicator_6, :indicator_7, :status)
    end

end
