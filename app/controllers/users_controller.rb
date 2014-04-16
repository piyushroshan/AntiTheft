class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :destroy]
  before_action :check_user, only: [:edit_user, :update_user, :destroy_user]
  #before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => [:show, :edit, :update]
  # GET /users
  # GET /users.json
  def index
    if current_user
      if current_user.is_admin?
        @users = User.all
      else
        render denied_url, :notice => 'Access Denied!!. You are not an admin'
      end
    else
      redirect_to login_url, :notice  => 'Access Denied!!. Login to continue'
    end
  end

  def welcome
    if current_user
      if current_user.is_admin?
        @users = User.all
        render :action => :index
      else
        render :action => :deny
      end
    else
      render :action => :deny
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    
  end

  def edit_user
    @user = User.find(params[:id])
    render :edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      redirect_to root_path, :notice => "Your account has been created. Please check your e-mail for your account activation instructions!"
    else
      redirect_to root_path, :notice => "User creation failed !!!"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path, :notice => 'User was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @user }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_users_path(@user.id), :notice => 'User was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @user }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def deny
    render
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  def destroy_user
    @user = current_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  def resend_activation
    if params[:username]
      @user = User.find_by_username params[:username]
      if @user && !@user.active?
        @user.deliver_activation_instructions!
        redirect_to root_path , :notice => "Please check your e-mail for your account activation instructions!"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def check_user
      if current_user.is_admin?
        @user = current_user

      else
        redirect_to root_path, :notice => 'Only admin can manage users'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:username, :email, :password, :password_confirmation, :roles_mask, :active)
    end
  end
