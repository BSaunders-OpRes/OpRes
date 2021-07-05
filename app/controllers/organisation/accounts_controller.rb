class Organisation::AccountsController < Organisation::BaseController
  def index; end

  def save_account
    if current_user.update(user_params)
      return redirect_to organisation_accounts_path, notice: 'User details has been updated successfully!'
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :job_title)
  end
end
