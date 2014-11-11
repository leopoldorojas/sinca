class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    if params[:approved] == "false"
      @users = User.find_all_by_approved(false).page(params[:page]).per(10)
    else
      @users = User.all.page(params[:page]).per(10)
    end
  end

  def edit
    @roles = roles
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: t('user.updated') }
        format.json { render :show, status: :ok, location: @user }
      else
        @roles = roles
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('user.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :credit_company_id, :approved, :role)
    end

    def roles
      Rails.application.config.user_roles.keys.map { |role| [t("user.roles.#{role}"), role] }
    end

end
