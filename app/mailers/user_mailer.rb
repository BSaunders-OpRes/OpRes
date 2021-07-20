class UserMailer < Devise::Mailer
  include Devise::Mailers::Helpers
  default template_path: 'users/mailer'
  default from: 'info@opres.uk'
end
