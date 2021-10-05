namespace :resilience_unit do

  desc "Update unit id to parent unit id to make consistency in bsl and supplier tables."
  task  change: :environment do
    ResilienceTicket&.all.each do |rt|
      rt.update(unit: rt.unit.parent)
    end
  end
end
