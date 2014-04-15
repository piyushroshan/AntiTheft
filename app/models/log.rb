require 'carrierwave/orm/activerecord'
class Log < ActiveRecord::Base
	belongs_to :device
	mount_uploader :log_file, LogFileUploader do |variable|
		def store_dir
    		"uploads/#{model.device_id}/#{model.class.to_s.underscore}/#{model.id}"
  		end
	end
end
