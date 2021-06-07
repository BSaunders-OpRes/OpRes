class Journey::SaveInstitutionService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    args.dig(:params, :institutions).reject! { |k, v| v[:name].blank? }

    institution_units_to_destroy, unit_products_to_destroy, unit_product_channels_to_destroy = [], [], []

    final_institution_units = []
    args.dig(:params, :institutions)&.each do |iid, idata|
      next if idata.dig(:name).blank? # means unchecked
      idata.delete(:name)
      idata.each do |index, iudata|
        institution_unit = args.dig(:country_unit).children.find_or_initialize_by(id: iudata.dig(:id))
        if institution_unit.persisted?
          institution_unit.update(name: iudata.dig(:name))
        else
          institution_unit.assign_attributes(
            type: Units::Institution,
            name: iudata.dig(:name) || Unit.build_name(args.dig(:region_operator).name, name, args.dig(:country_operator).name),
            institution_id: iid
          )
          institution_unit.save
        end
        final_institution_units << institution_unit.id

        final_unit_products = []
        iudata.dig(:products)&.each do |pid, pdata|
          next if pdata.dig(:name).blank? # means unchecked
          unit_product = institution_unit.unit_products.find_or_create_by(product_id: pid)
          final_unit_products << unit_product.id

          final_product_channels = []
          pdata.dig(:channels)&.each do |cid, cname|
            unit_product_channel = unit_product.unit_product_channels.find_or_create_by(channel_id: cid)
            final_product_channels << unit_product_channel.id
          end
          unit_product_channels_to_destroy << unit_product.unit_product_channels.map(&:id) - final_product_channels
        end
        unit_products_to_destroy << institution_unit.unit_products.map(&:id) - final_unit_products
      end
    end
    institution_units_to_destroy = args.dig(:country_unit).children.map(&:id) - final_institution_units

    Units::Institution.where(id: institution_units_to_destroy.flatten).destroy_all
    UnitProduct.where(id: unit_products_to_destroy.flatten).destroy_all
    UnitProductChannel.where(id: unit_product_channels_to_destroy.flatten).destroy_all
  end
end
