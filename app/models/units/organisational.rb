class Units::Organisational < Unit
  # Modules #
  include TenantConcern

  # Callbacks #
  after_create  :create_tenant
  after_destroy :destroy_tenant
end
