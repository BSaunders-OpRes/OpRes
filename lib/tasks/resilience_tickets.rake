namespace :resilience_tickets do

  desc "Create resilience tickets for existing bsls."
  task  create: :environment do
   Graphs::CreateResilienceTicketsService.call(nil)
  end

  desc "Update resilience ID's for existing resilience tickets."
  task unique_resilience_id: :environment do
    ResilienceTicket.all.order(id: :asc).each_with_index do |rt, index|
      resilience_id = 100000 + index
      rt.update(rgid: resilience_id)
    end
  end
end
