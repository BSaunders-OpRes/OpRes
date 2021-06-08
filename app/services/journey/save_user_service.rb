class Journey::SaveUserService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    users_info, message, failing_users = [], '', []
    if args.dig(:params, :users, :multiple, :csv).blank?
      message = args.dig(:params, :users, :single, :message)
      args.dig(:params, :users, :single, :data)&.each do |index, user_data|
        user_data[:email] = user_data.dig(:email).squish
        next if user_data.dig(:email).blank?

        users_info << {
          basic: {
            unit_id:    args.dig(:organisational_unit).id,
            first_name: user_data.dig(:first_name),
            last_name:  user_data.dig(:last_name),
            email:      user_data.dig(:email),
            password:   Devise.friendly_token,
            role:       User.roles[:unit_admin]
          },
          advance: {
            permission: user_data.dig(:permission)
          }
        }
      end
    else
      message = args.dig(:params, :users, :multiple, :message)
      emails = CSV.parse(args.dig(:params, :users, :multiple, :csv))
      emails.flatten.compact.each do |email|
        email = email.squish
        next if email.blank?

        users_info << {
          basic: {
            unit:       args.dig(:organisational_unit),
            email:      email,
            password:   Devise.friendly_token,
            role:       User.roles[:unit_admin],
          },
          advance: {
            permission: args.dig(:params, :users, :multiple, :permission)
          }
        }
      end
    end

    users_info.each do |user_data|
      user = args.dig(:organisational_unit)
                 .users
                 .create_with(user_data.dig(:basic))
                 .find_or_create_by(email: user_data.dig(:basic, :email))

      if user.errors.present?
        failing_users << {
          "#{user.email}": user.errors
        }
        next
      end

      manager = user.managers.find_or_initialize_by(unit: args.dig(:regional_unit))
      manager.permission = user_data.dig(:advance, :permission)

      InvitationMailer.invite_admin(user, user_data.dig(:basic, :password), message, args.dig(:regional_unit)).deliver_later unless manager.persisted?
      manager.save
    end

    failing_users
  end
end
