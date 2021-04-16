class Admin::ChannelsController < Admin::BaseController
  before_action :load_channel, only: %i[edit update show destroy]

  def index
    @channels = Channel.order(id: :desc)
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      redirect_to admin_channels_path, notice: 'Channel has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @channel.update(channel_params)
      redirect_to admin_channels_path, notice: 'Channel has been updated successfully!'
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

    redirect_to admin_channels_path
  end

  private

  def load_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name, :description, :active)
  end
end
