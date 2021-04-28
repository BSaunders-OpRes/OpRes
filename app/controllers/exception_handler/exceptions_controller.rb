module ExceptionHandler
  class ExceptionsController < ApplicationController

    respond_to :html, :js, :json, :xml

    protect_from_forgery

    skip_before_action :authenticate_user!, raise: false

    before_action { |e| @exception = ExceptionHandler::Exception.new request: e.request }
    before_action { @exception.save if @exception.valid? && ExceptionHandler.config.try(:db) }
    before_action { |e| e.request.format = :html unless self.class.respond_to.include? e.request.format }

    helper Rails.application.routes.url_helpers

    layout :layout

    def show
      respond_with @exception, status: @exception.status
    end

    private

    def layout option = ExceptionHandler.config.options(@exception.status, :layout)
      (option.present? || option.nil?) ? option : 'exception'
    end
  end
end
