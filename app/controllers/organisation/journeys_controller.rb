require 'csv'

class Organisation::JourneysController < Organisation::BaseController
  before_action :load_step_data, only: %i[show]

  def show
    handle_post_request if request.post?
    handle_get_request

    respond_to do |format|
      format.html {}
      format.js   {}
    end
  end

  def build_institution
    @institution  = Institution.find(params[:institution])
    @index        = params[:index].to_i
  end

  private

  ##################
  # Load Main Data #
  def load_step_data
    @step, region_name, country_alpha2 = params[:id].split('/')

    if region_name.present?
      @region_operator = Region.find_by(name: region_name.upcase)
      @regional_unit   = organisational_unit.find_children_by_region(@region_operator.id)
    end

    if country_alpha2.present?
      @country_operator = Country.find_by(alpha2: country_alpha2.upcase)
      @country_unit     = organisational_unit.find_children_by_country(@country_operator.id)
    end
  end

  #############
  # Save Data #
  def handle_post_request
    if params.dig(:organisation).present?
      save_organisation_data
    elsif params.dig(:regions).present?
      save_regions_data
    elsif params.dig(:countries).present?
      save_countries_data
    elsif params.dig(:institutions).present?
      save_institutions_data
    elsif params.dig(:users).present?
      save_users_data
    end
  end

  def save_organisation_data
    organisational_unit.update(name: params.dig(:organisation, :name))
  end

  def save_regions_data
    params.dig(:regions)&.each do |id, name|
      organisational_unit.children
                         .create_with(type: Units::Regional, name: Unit.build_name('', organisational_unit.name, name))
                         .find_or_create_by(region_id: id)
    end
  end

  def save_countries_data
    params.dig(:countries)&.each do |id, name|
      @regional_unit.children
                    .create_with(type: Units::Country, name: Unit.build_name('', organisational_unit.name, name))
                    .find_or_create_by(country_id: id)
    end
  end

  def save_institutions_data
    params.dig(:institutions)&.each do |iid, idata|
      idata.delete(:name)
      idata.each do |index, iudata|
        next if iudata.dig(:products).blank?

        institution_unit = @country_unit.children.find_or_initialize_by(id: iudata.dig(:id))
        if institution_unit.persisted?
          institution_unit.update(name: iudata.dig(:name))
        else
          institution_unit.assign_attributes(
            type: Units::Institution,
            name: iudata.dig(:name) || Unit.build_name(@region_operator.name, name, @country_operator.name),
            institution_id: iid
          )
          institution_unit.save
        end

        iudata.dig(:products)&.each do |pid, pdata|
          unit_product = institution_unit.unit_products.find_or_create_by(product_id: pid)
          pdata.dig(:channels)&.each do |cid, cname|
            unit_product.unit_product_channels.find_or_create_by(channel_id: cid)
          end
        end
      end
    end
  end

  def save_users_data
    users_info, message = [], ''

    if params.dig(:users, :multiple, :csv).blank?
      message = params.dig(:users, :single, :message)
      params.dig(:users, :single, :data)&.each do |index, user_data|
        user_data[:email] = user_data.dig(:email).squish
        next if user_data.dig(:email).blank?

        users_info << {
          basic: {
            unit_id:    organisational_unit.id,
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
      message = params.dig(:users, :multiple, :message)
      emails = CSV.parse(params.dig(:users, :multiple, :csv))
      emails.flatten.compact.each do |email|
        email = email.squish
        next if email.blank?

        users_info << {
          basic: {
            unit:       organisational_unit,
            email:      email,
            password:   Devise.friendly_token,
            role:       User.roles[:unit_admin],
          },
          advance: {
            permission: params.dig(:users, :multiple, :permission)
          }
        }
      end
    end

    users_info.each do |user_data|
      user = organisational_unit.users.create_with(user_data.dig(:basic))
                 .find_or_create_by(email: user_data.dig(:basic, :email))

      next if user.errors.present?

      manager = user.managers.find_or_initialize_by(unit: @country_unit)
      manager.permission = user_data.dig(:advance, :permission)

      InvitationMailer.invite_admin(user, user_data.dig(:basic, :password), message, @country_unit).deliver_later unless manager.persisted?
      manager.save
    end
  end

  #############
  # Load Data #
  def handle_get_request
    case @step
    when 'welcome'
    when 'organisation'
    when 'regions'
      load_regions_data
    when 'account_setup'
    when 'countries'
      load_countries_data
    when 'country_setup'
    when 'institutions'
      load_institutions_data
    when 'invite_user'
    when 'finish'
    end
  end

  def load_regions_data
    @all_regions = Region.all
  end

  def load_countries_data
    @all_countries = @region_operator.countries
  end

  def load_institutions_data
    @all_institutions = organisational_unit.institutions
  end
end
