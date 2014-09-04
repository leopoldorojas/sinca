json.array!(@indicators) do |indicator|
  json.extract! indicator, :id, :register_date, :credit_company, :file_name, :indicator_1, :indicator_2, :indicator_3, :indicator_4, :indicator_5, :indicator_6, :indicator_7, :status
  json.url indicator_url(indicator, format: :json)
end
