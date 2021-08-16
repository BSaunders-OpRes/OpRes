class InvitationMailer < ApplicationMailer
  def invite_admin(user, password, message, country_unit, current_user_email)
    @user     = user
    @password = password
    @message  = message
    @organisational_unit = @user.unit
    @sender_email        = current_user_email

    if @user.root_user?
      mail(to: @user.email, subject: "Join #{@organisational_unit.name}!")
    else
      @managing_unit = country_unit
      mail(to: @user.email, subject: "Join #{@managing_unit.name}!")
    end
  end
end
