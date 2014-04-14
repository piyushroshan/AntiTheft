class Device < ActiveRecord::Base
	belongs_to :user
	has_many :logs, :dependent => :destroy
end
