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
          unit_id:    args.dig(:organisational_unit).id,
          first_name: user_data.dig(:first_name),
          last_name:  user_data.dig(:last_name),
          email:      user_data.dig(:email),
          password:   Devise.friendly_token,
          role:       user_data.dig(:role),
          invited_status: true
        }
      end
    else
      message = args.dig(:params, :users, :multiple, :message)
      emails  = CSV.parse(args.dig(:params, :users, :multiple, :csv))
      emails.flatten.compact.each do |email|
        email = email.squish
        next if email.blank?

        users_info << {
          unit:       args.dig(:organisational_unit),
          email:      email,
          password:   Devise.friendly_token,
          role:       args.dig(:params, :users, :multiple, :role),
          invited_status: true
        }
      end
    end

    users_info.each do |user_data|
      user = args.dig(:organisational_unit)
                 .users
                 .create_with(user_data)
                 .find_or_create_by(email: user_data.dig(:email))
      if user.errors.present?
        failing_users << {
          "#{user.email}": user.errors
        }
        next
      end

      managers = []
      if user.root_user?
        user.unit.children.each do |region|
          managers << user.managers.find_or_initialize_by(unit_id: region.id)
        end
      else
        managers << user.managers.find_or_initialize_by(unit: args.dig(:regional_unit))
      end

      InvitationMailer.invite_admin(
        user,
        user_data.dig(:password),
        message,
        user.root_user? ? '' : args.dig(:regional_unit),
        args.dig(:current_user_email)
      ).deliver_later if managers.select { |m| m.id.blank? }.size.positive?

      managers_data = Manager.import managers, on_duplicate_key_ignore: true
    end

    failing_users
  end
end
