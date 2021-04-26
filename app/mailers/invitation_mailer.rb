class InvitationMailer < ApplicationMailer
   def invite_org_admin(user, password)
    @user     = user
    @password = password
    @organisational_unit = @user.unit

    mail(to: @user.email, subject: "Join #{@organisational_unit.name}!")
  end
end
