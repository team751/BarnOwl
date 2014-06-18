class TimecardManagerController < ApplicationController
  before_filter :authenticate_user!
  def index
    @year = params[:year]
    @year ||= 2014
  end
end
