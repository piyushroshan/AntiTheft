require 'carrierwave/orm/activerecord'
class Log < ActiveRecord::Base
	belongs_to :device
	mount_uploader :log_file, LogFileUploader
end
