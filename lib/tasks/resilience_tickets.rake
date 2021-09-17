namespace :resilience_tickets do

  desc "Create resilience tickets for existing bsls."
  task  create: :environment do
   Graphs::CreateResilienceTicketsService.call(nil)
  end
end
