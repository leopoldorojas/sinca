class CreditCompaniesController < ApplicationController
  before_action :set_credit_company, only: [:show, :edit, :update, :destroy]

  # GET /credit_companies
  # GET /credit_companies.json
  def index
    @credit_companies = CreditCompany.all.page(params[:page]).per(10)
  end

  # GET /credit_companies/1
  # GET /credit_companies/1.json
  def show
  end

  # GET /credit_companies/new
  def new
    @credit_company = CreditCompany.new
  end

  # GET /credit_companies/1/edit
  def edit
  end

  # POST /credit_companies
  # POST /credit_companies.json
  def create
    @credit_company = CreditCompany.new(credit_company_params)

    respond_to do |format|
      if @credit_company.save
        format.html { redirect_to @credit_company, notice: t('credit_company.created') }
        format.json { render :show, status: :created, location: @credit_company }
      else
        format.html { render :new }
        format.json { render json: @credit_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credit_companies/1
  # PATCH/PUT /credit_companies/1.json
  def update
    respond_to do |format|
      if @credit_company.update(credit_company_params)
        format.html { redirect_to @credit_company, notice: t('credit_company.updated') }
        format.json { render :show, status: :ok, location: @credit_company }
      else
        format.html { render :edit }
        format.json { render json: @credit_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_companies/1
  # DELETE /credit_companies/1.json
  def destroy
    @credit_company.destroy
    respond_to do |format|
      format.html { redirect_to credit_companies_url, notice: t('credit_company.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_company
      @credit_company = CreditCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_company_params
      params.require(:credit_company).permit(:name, :identifier, :contact, :phone, :email, :website, :location_id)
    end
end
