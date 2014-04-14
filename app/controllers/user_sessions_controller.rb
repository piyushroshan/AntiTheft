class UserSessionsController < ApplicationController
  before_action :set_user_session, only: [:new, :create, :destroy]


  # GET /user_sessions/new
  def new
    if current_user
      redirect_to devices_path, :notice => "Please logout before using any other account"
    else
      @user_session = UserSession.new
      render
    end
  end


  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(user_session_params)
    respond_to do |format|
      if @user_session.save
        format.html { redirect_to root_path, :notice => 'Login successful.' }
        format.json { render action: 'show', status: :created, location: @user_session }
      elsif @user_session.attempted_record && !@user_session.invalid_password? && !@user_session.attempted_record.active?
        @string = render_to_string(:partial => 'user_sessions/not_active.erb', :locals => { :user => @user_session.attempted_record })
        format.html { redirect_to :login, notice: @string }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to :login, notice: "Invalid username or password" }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /user_sessions/1
  # # PATCH/PUT /user_sessions/1.json
  # def update
  #   respond_to do |format|
  #     if @user_session.update(user_session_params)
  #       format.html { redirect_to @user_session, notice: 'User session was successfully updated.' }
  #       format.json { render action: 'show', status: :ok, location: @user_session }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @user_session.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session.destroy
    respond_to do |format|
      format.html { redirect_to root_url, :notice => 'Goodbye!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_session
      @user_session = UserSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_session_params
      params.require(:user_session).permit(:username, :password)
    end
end
