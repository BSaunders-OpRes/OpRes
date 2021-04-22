class OrgUnitInitWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform()
  end
end
