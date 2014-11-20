namespace :db do
	desc "Populate Companies Short Names with the value of Company Name"
	task :populate_short_names => :environment do
    CreditCompany.where(short_name: ['', nil]).update_all("short_name = name")
	end
end