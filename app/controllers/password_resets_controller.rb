class PasswordResetsController < ApplicationController  
before_filter :load_user_using_perishable_token, :only => [:edit, :update]  

	def new  
		render  
	end  

	def create  
		@user = User.find_by_email(params[:email])  
		if @user  
			@user.deliver_password_reset_instructions!  
			flash[:notice] = "Instructions to reset your password have been emailed to you. " +  
			"Please check your email."  
			redirect_to root_url  
		else  
			flash[:notice] = "No user was found with that email address"  
			render :action => :new  
		end  
	end 


	def edit
		if @user  
			render  
		else
			flash[:notice] = "Token expired!!"
			redirect_to forgot_password_url
		end
	end 

	def update 
		@user.password = params[:password]
		@user.password_confirmation = params[:password_confirmation]
		@user.email = params[:email]  
		if @user.save  
			flash[:notice] = "Password successfully updated"  
			redirect_to root_url 
		else 
			flash[:notice] = "Password successfully updated"
			redirect_to password_reset_form_url  
		end  
	end  

	private  
	def load_user_using_perishable_token  
		@user = User.find_using_perishable_token(params[:id])  
		unless @user  
			flash[:notice] = "We're sorry, but we could not locate your account. " +  
			"If you are having issues try copying and pasting the URL " +  
			"from your email into your browser or restarting the " +  
			"reset password process."  
			redirect_to forgot_password_url  
		end  
	end  
end





