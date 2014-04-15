class LogsController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  # GET /logs
  # GET /logs.json
  def index
    if current_user
      @device = Device.find(params[:device_id])
      if current_user.is_admin?
        @devices = Device.all
      else
        @devices = Device.where(:user_id => current_user.id)
      end
      @logs = Log.where(:device_id => @device.id)
    else
      redirect_to devices_path, :notice => "You can only view logs of your devices"
    end
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs
  # POST /logs.json
  def create
    @log = Log.new
    @device = Device.find_by_macaddress(params[:macaddress])
    @ip_address = request.remote_ip
    @log_file = params[:log_file]
    @log.device = @device
    @log.ip_address = @ip_address
    @log.log_file = @log_file
    if @device.secret_key == params[:secret_key]
      respond_to do |format|
        if @log.save
          format.html { redirect_to index_logs_path(@device.id), notice: 'Log was successfully created.' }
          format.json { render action: 'show', status: :created, location: index_logs_path(params[:device_id]) }
        else
          format.html { render action: 'new' }
          format.json { render json: @log.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_log_path, :notice => 'Invalied MAC Address or Secret key'
    end
  end

  # PATCH/PUT /logs/1
  # PATCH/PUT /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: 'Log was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @log }
      else
        format.html { render action: 'edit' }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    respond_to do |format|
      format.html { redirect_to index_logs_path(params[:device_id]) }
      format.json { head :no_content }
    end
  end

  def post
    @log = Log.new
    @log.device_id = params[:mac_address]
    @log.ip_address = ""
    @log.logfile = params[:log_file]
    if @log.device.secret_key == params[:secret_key]
      if @log.save
        return 1
      else
        return 0
      end
    else
      return 404
    end
  end


  def download
    @owner = Device.find(params[:device]).user
    if current_user == @owner
      path = "#{Rails.root}/uploads/"+params[:device]+'/'+params[:model]+'/'+params[:id].to_s+"/"+params[:basename]+"."+params[:extension]
      send_file path, :x_sendfile=>true
    else
      redirect_to devices_path, :notice => "Error!!!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      #@log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.permit(:macaddress, :secret_key, :log_file)
    end
end
