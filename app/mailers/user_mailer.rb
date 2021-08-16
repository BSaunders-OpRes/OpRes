class UserMailer < Devise::Mailer
  include Devise::Mailers::Helpers
  default template_path: 'users/mailer'
  default from: 'hq@opres.uk'
end
