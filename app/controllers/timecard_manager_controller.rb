class TimecardManagerController < ApplicationController
  before_filter :authenticate_user!
  def index
    @year = params[:year]
    @year ||= 2014
  end
  
  def getUsersOnDate
    date = Date.strptime(params[:date], "%Y%m%d")
    render :json => TimeEntry.studentsOnDate(date).map(&:full_name)
  end
end
