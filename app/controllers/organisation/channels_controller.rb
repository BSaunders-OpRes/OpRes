class Organisation::ChannelsController < Organisation::BaseController
  before_action :authenticate_root_user
  before_action :load_channel, only: %i[edit update show destroy]

  def index
    @channels = organisational_unit.channels.order(id: :desc)
  end

  def new
    @channel = organisational_unit.channels.new
  end

  def create
    @channel = organisational_unit.channels.new(channel_params)

    if @channel.save
      redirect_to organisation_channels_path, notice: 'Channel has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @channel.update(channel_params)
      redirect_to organisation_channels_path, notice: 'Channel has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @channel.destroy
      flash[:notice] = 'Channel has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy channel at the moment!'
    end

    redirect_to organisation_channels_path
  end

  private

  def load_channel
    @channel = organisational_unit.channels.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name, :description)
  end
end
