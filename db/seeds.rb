
# Application Admin #
User.create_with(name: 'Application Admin', password: 'Adm!n123', role: User.roles[:app_admin]).find_or_create_by(email: 'admin@opres.uk')

# Institutions #
%w[Retail\ Bank, Business\ Bank Commercial\ Bank Investment\ Bank Union\ Bank Wealth\ Management].each do |institution|
  Institution.create_with(description: institution, active: true).find_or_create_by(name: institution)
end

# Products #
%w[Retail\ Bank\ A Current\ Account Mortgages Loans Credit\ Cards Savings\ Accounts].each do |product|
  Product.create_with(description: product, active: true).find_or_create_by(name: product)
end

# Channels #
%w[Web Mobile ATM Branch Telephony].each do |channel|
  Channel.create_with(description: channel, active: true).find_or_create_by(name: channel)
end
