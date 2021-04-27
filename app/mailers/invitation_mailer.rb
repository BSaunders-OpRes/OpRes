class InvitationMailer < ApplicationMailer
   def invite_org_admin(user, password)
    @user     = user
    @password = password
    @organisational_unit = @user.unit

    mail(to: @user.email, subject: "Join #{@organisational_unit.name}!")
  end

  def invite_unit_admin(user, password)
    @user     = user
    @password = password
    @organisational_unit = @user.unit
    @managing_unit       = @user.managing_unit

    mail(to: @user.email, subject: "Join #{@managing_unit.name}!")
  end
end
