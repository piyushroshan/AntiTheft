class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    if current_user
      if current_user.is_admin?
        @devices = Device.all
      else
        @devices = Device.where(:user_id => current_user.id)
      end
    else
      redirect_to login_url, :notice => "Please login to manage your devices"
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
    if (@device.user == current_user) or current_user.is_admin? 
      render
    else
      redirect_to devices_url, :notice => 'Access denied! You can edit your device only'
    end
  end

  # POST /devices
  # POST /devices.json
  def create
    if Device.find_by :macaddress => params[:macaddress]
      redirect_to new_device_url, :notice => 'Device already registered, If there is any issue please contact admin.'
    else
      @device = Device.new(device_params)
      @device.user = current_user

      respond_to do |format|
        if @device.save
          format.html { redirect_to @device, notice: 'Device was successfully created.' }
          format.json { render action: 'show', status: :created, location: @device }
        else
          format.html { render action: 'new' }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    if @device.user == current_user or current_user.is_admin?
      respond_to do |format|
        if @device.update(device_params)
          format.html { redirect_to @device, notice: 'Device was successfully updated.' }
          format.json { render action: 'show', status: :ok, location: @device }
        else
          format.html { render action: 'edit' }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to devices_url, :notice => 'Access denied! You can update your device only'
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    if @device.user == current_user or current_user.is_admin?
      @device.destroy
      respond_to do |format|
        format.html { redirect_to devices_url }
        format.json { head :no_content }
      end
    else
        redirect_to devices_url, :notice => 'Access denied! You can delete your device only'
    end
  end

  def check_stolen
    @newdevice = Device.find_by(:macaddress => params[:macaddress])
    logger.error(device_params.to_s)
    if @newdevice
      respond_to do |format|
        msg = { :status => @newdevice.stolen?.to_s, :message => "Success!"}
        format.html { redirect_to devices_url, :notice => "Device stolen" }
        format.json  { render :json => msg } # don't do msg.to_json
      end
    else
      respond_to do |format|
        msg = { :status => false , :message => "Device not found!"}
        format.html { redirect_to devices_url, :notice => "Device not found" }
        format.json  { render :json => msg } # don't do msg.to_json
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.permit(:macaddress, :nickname, :description, :user_id, :stolen, :secret_key, :format)
    end
end
