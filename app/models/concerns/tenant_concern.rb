module TenantConcern
  extend ActiveSupport::Concern

  included do
    def create_tenant
      Apartment::Tenant.create(name)
    end

    def destroy_tenant
      Apartment::Tenant.drop(name)
    end
  end
end
