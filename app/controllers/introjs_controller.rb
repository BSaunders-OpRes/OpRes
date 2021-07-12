class IntrojsController < ApplicationController
  def visited
    current_user && current_user.update(
      introjs: current_user.introjs.merge(introjs_params)
    )
  end

  private

  def introjs_params
    params.require(:introjs).permit!
  end
end
