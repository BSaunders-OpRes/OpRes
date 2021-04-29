class Organisation::AdminsController < Organisation::BaseController
  before_action :load_admin, only: %i[edit update show destroy]
  before_action :load_unit,  only: %i[create update]

  def index
    @admins = organisational_unit.users.where(role: [User.roles[:org_admin], User.roles[:unit_admin]])
  end

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(user_params)

    if @admin.save
      assign_as_manager
      InvitationMailer.invite_admin(@admin, @admin.password).deliver_later
      redirect_to organisation_admins_path, notice: 'Admin has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    skip_password_validation?

    if @admin.update(user_params)
      assign_as_manager
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
          .merge(role: @unit.organisational? ? User.roles[:org_admin]: User.roles[:unit_admin], unit: organisational_unit)
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

  def load_unit
    @unit = Unit.find(params.dig('managing_unit'))
  end
end
