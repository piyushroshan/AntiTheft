# app/models/notifier.rb  
class Notifier < ActionMailer::Base  
	default_url_options[:host] = "http://0.0.0.0:3000"  
	default :from => "noreply@antitheft.com"  

	def password_reset_instructions(user)
		@user = user
		mail(:to => user.email, :subject => "Password Reset Instructions")  
	end  

	def activation_instructions(user)
		@user = user
		mail(:to => user.email, :subject => "Activation Instructions" )
	end

	def welcome(user)
		mail(:to => user.email, :subject => "Welcome to AntiTheft Protection" )
	end
	# def deliver_password_reset_instructions(user)
	# 	:to
	# 	mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")  
	# 	subject       "Password Reset Instructions"  
	# 	from          "AntiTheft"  
	# 	recipients    user.email  
	# 	sent_on       Time.now  
	# 	body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
	# end  
end  