class OrgUnitInitWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(org_unit_id)
    org_unit = Units::Organisational.find(org_unit_id)
    pre_institutions = PreInstitution.where(unit_type: org_unit.unit_type)

    pre_institutions.each do |pre_institution|

      institution = org_unit.institutions.create_with(description: pre_institution.description).find_or_create_by(name: pre_institution.name)
      products = []
      pre_institution.pre_products.each do |pre_product|
        product   = org_unit.products.create_with(description: pre_product.description).find_or_create_by(name: pre_product.name)
        products << product
        channels = []
        pre_product.pre_channels.each do |pre_channel|
          channel = org_unit.channels.create_with(description: pre_channel.description).find_or_create_by(name: pre_channel.name)
          channels << channel
        end
        product.channel_ids = channels.map(&:id)
      end
      institution.product_ids = products.map(&:id)
    end
  end
end
