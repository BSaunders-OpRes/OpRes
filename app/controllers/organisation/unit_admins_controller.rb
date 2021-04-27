class Organisation::UnitAdminsController < Organisation::BaseController
  before_action :load_unit_admin, only: %i[edit update show destroy]

  def index
    @unit_admins = organisational_unit.users.unit_admin
  end

  def new
    @unit_admin = User.new
  end

  def create
    @unit_admin = User.new(user_params)

    if @unit_admin.save
      assign_as_manager
      InvitationMailer.invite_unit_admin(@unit_admin, @unit_admin.password).deliver_later
      redirect_to organisation_unit_admins_path, notice: 'Unit admin has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    skip_password_validation?

    if @unit_admin.update(user_params)
      assign_as_manager
      redirect_to organisation_unit_admins_path, notice: 'Unit admin has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @unit_admin.destroy
      flash[:notice] = 'Unit admin has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy unit admin at the moment!'
    end

    redirect_to organisation_unit_admins_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(role: User.roles[:unit_admin], unit: organisational_unit)
  end

  def load_unit_admin
    @unit_admin = organisational_unit.users.find(params[:id])
  end

  def skip_password_validation?
    @unit_admin.skip_password_validation = params.dig(:user, :password).blank? &&
                                           params.dig(:user, :password_confirmation).blank?
  end

  def assign_as_manager
    @unit_admin.managing_unit&.update(manager_id: nil)
    organisational_unit.find_children(params[:managing_unit].to_i)&.update(manager_id: @unit_admin.id)
  end
end
