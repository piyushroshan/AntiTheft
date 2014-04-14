json.array!(@logs) do |log|
  json.extract! log, :id, :ip_address, :device_id
  json.url log_url(log, format: :json)
end
