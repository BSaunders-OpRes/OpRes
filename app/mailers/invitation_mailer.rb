class InvitationMailer < ApplicationMailer
  def invite_admin(user, password, message, country_unit)
    @user     = user
    @password = password
    @message  = message
    @organisational_unit = @user.unit

    if @user.root_user?
      mail(to: @user.email, subject: "Join #{@organisational_unit.name}!")
    else
      @managing_unit =country_unit
      mail(to: @user.email, subject: "Join #{@managing_unit.name}!")
    end
  end
end
