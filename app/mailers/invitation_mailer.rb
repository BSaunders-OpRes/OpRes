class InvitationMailer < ApplicationMailer
  def invite_admin(user, password)
    @user     = user
    @password = password
    @organisational_unit = @user.unit

    if @user.org_admin?
      mail(to: @user.email, subject: "Join #{@organisational_unit.name}!")
    else
      @managing_unit = @user.managing_unit
      mail(to: @user.email, subject: "Join #{@managing_unit.name}!")
    end
  end
end
