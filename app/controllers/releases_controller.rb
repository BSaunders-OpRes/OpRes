class ReleasesController < ApplicationController
  layout 'organisation'
  before_action :load_release

  def show
   @release.get_notification.user_notifications.find_by(user_id: current_user.id).viewed!
  end
  
  private

  def load_release
    @release = Release.find_by(id: params[:id])
  end

end
