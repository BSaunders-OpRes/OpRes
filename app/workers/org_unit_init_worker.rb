class OrgUnitInitWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(org_unit_id)
    org_unit = Units::Organisational.find(org_unit_id)

    institutions = []
    PreInstitution.all.each do |pre_institution|
      institutions << org_unit.institutions.new(name: pre_institution.name, description: pre_institution.description)
    end
    Institution.import institutions

    products = []
    PreProduct.all.each do |pre_product|
      products << org_unit.products.new(name: pre_product.name, description: pre_product.description)
    end
    Product.import products

    channels = []
    PreChannel.all.each do |pre_channel|
      channels << org_unit.channels.new(name: pre_channel.name, description: pre_channel.description)
    end
    Channel.import channels
  end
end
