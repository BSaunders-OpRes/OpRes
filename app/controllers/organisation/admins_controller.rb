class Organisation::AdminsController < Organisation::BaseController
  before_action :authenticate_org_admin
  before_action :load_admin, only: %i[edit update show destroy]

  def index
    @admins = organisational_unit.users.where(role: [User.roles[:org_admin], User.roles[:unit_admin]])
  end

  def new; end

  def create
    regional_unit_id = params.dig(:users, :multiple, :csv).blank? ? params.dig(:single_regional_unit): params.dig(:multiple_regional_unit)
    regional_unit    = organisational_unit.children.find_by_id(regional_unit_id)

    failing_users = Journey::SaveUserService.call(
      organisational_unit: organisational_unit,
      regional_unit: regional_unit,
      params: params
    )

    redirect_to organisation_admins_path, notice: "Admins have been created successfully! #{ failing_users.present? ? "Except #{failing_users.keys.to_sentence}" : '' }"
  end

  def edit; end

  def update
    @unit = Unit.find(params.dig('id'))

    skip_password_validation?

    if @admin.update(user_params)
      redirect_to organisation_admins_path, notice: 'Admin has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @admin.destroy
      flash[:notice] = 'Admin has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy admin at the moment!'
    end

    redirect_to organisation_admins_path
  end

  private

  def user_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :password, :password_confirmation)
          .merge(role: @unit.organisational_unit? ? User.roles[:org_admin]: User.roles[:unit_admin], unit: organisational_unit)
  end

  def load_admin
    @admin = organisational_unit.users.find(params[:id])
  end

  def skip_password_validation?
    @admin.skip_password_validation = params.dig(:user, :password).blank? &&
                                      params.dig(:user, :password_confirmation).blank?
  end

  def assign_as_manager
    @admin.managing_unit&.update(manager_id: nil)
    organisational_unit.find_children(params[:managing_unit].to_i)&.reload&.update(manager_id: @admin.id) if @admin.unit_admin?
  end

end
