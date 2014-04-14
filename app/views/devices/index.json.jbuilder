json.array!(@devices) do |device|
  json.extract! device, :id, :macaddress, :nickname, :description, :user_id, :stolen, :secret_key
  json.url device_url(device, format: :json)
end
