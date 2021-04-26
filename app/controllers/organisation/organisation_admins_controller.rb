class Organisation::OrganisationAdminsController < Organisation::BaseController
  before_action :load_organisation_admin, only: %i[edit update show destroy]

  def index
    @org_admins = User.org_admin.where(unit: organisational_unit)
  end

  def new
    @org_admin = User.new
  end

  def create
    @org_admin = User.new(user_params)

    if @org_admin.save
      InvitationMailer.invite_org_admin(@org_admin, @org_admin.password).deliver_later
      redirect_to organisation_organisation_admins_path, notice: 'Organisation admin has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    skip_password_validation?
    if @org_admin.update(user_params)
      redirect_to organisation_organisation_admins_path, notice: 'Organisation admin has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @org_admin.destroy
      flash[:notice] = 'Organisation admin has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy organisation admin at the moment!'
    end

    redirect_to organisation_organisation_admins_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(role: User.roles[:org_admin], unit: organisational_unit)
  end

  def load_organisation_admin
    @org_admin = User.find(params[:id])
  end

  def skip_password_validation?
    @org_admin.skip_password_validation = params.dig(:user, :password).blank? &&
                                          params.dig(:user, :password_confirmation).blank?
  end
end
