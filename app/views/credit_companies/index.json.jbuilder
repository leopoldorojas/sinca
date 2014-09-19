json.array!(@credit_companies) do |credit_company|
  json.extract! credit_company, :id, :name, :identifier, :contact, :phone, :email, :website, :location_id
  json.url credit_company_url(credit_company, format: :json)
end
