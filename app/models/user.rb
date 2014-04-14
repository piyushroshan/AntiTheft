require 'rubygems'
require 'role_model'
class User < ActiveRecord::Base
	acts_as_authentic
	# attr_accessor :roles_id
	# in real life this would usually be a persistent attribute,
	# e.g. if your User model is persisted in a SQL-DB add an integer
	# column named roles_mask to your users table -- just remove/replace
	# above attr_accessor line with whatever is needed for your
	# persistence solution
	has_many :devices, :dependent => :destroy
	include RoleModel

	# if you want to use a different integer attribute to store the
	# roles in, set it with roles_attribute :my_roles_attribute,
	# :roles_mask is the default name
	roles_attribute :roles_mask

	# declare the valid roles -- do not change the order if you add more
	# roles later, always append them at the end!
	roles :admin

	def activate!
    	self.active = true
    	save
  	end

	def deliver_password_reset_instructions!  
		reset_perishable_token!  
		Notifier.password_reset_instructions(self).deliver
	end

	def deliver_welcome!
    	reset_perishable_token!
    	Notifier.welcome(self).deliver
  	end

	def deliver_activation_instructions!
    	reset_perishable_token!
    	Notifier.activation_instructions(self).deliver
  	end
end


