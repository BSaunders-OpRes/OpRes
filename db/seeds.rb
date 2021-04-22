
# Application Admin #
user = User.create_with(first_name: 'Application', last_name: 'Admin', password: 'Adm!n123', role: User.roles[:app_admin]).find_or_create_by(email: 'admin@opres.uk')
user.confirm

# Institutions #
%w[Retail\ Bank Business\ Bank Commercial\ Bank Investment\ Bank Union\ Bank Wealth\ Management].each do |institution|
  PreInstitution.create_with(description: institution).find_or_create_by(name: institution)
end

# Products #
%w[Current\ Account Mortgages Loans Credit\ Cards Savings\ Accounts Checking\ Account Treasury\ Service Payment\ Processing Securities Mergers\ &\ Acqusition Fixed\ Income Foreign\ Exchange Underwriting Derivative Equity Comodity].each do |product|
  PreProduct.create_with(description: product).find_or_create_by(name: product)
end

# Channels #
%w[Web Mobile ATM Branch Telephony].each do |channel|
  PreChannel.create_with(description: channel).find_or_create_by(name: channel)
end
