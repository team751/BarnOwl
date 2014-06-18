class Api::TimeloggingController < ApplicationController
  def fingerScanned
    users = User.where(:fingerprint_id => params[:fingerprint_id])
    
    # Check user exists
    if users.count == 0
      render :json => {:success => false, :error => {:message => "User not found"}}
      return
    else
      # Set user
      user = users.first
      # Update timecard
      render :json => user.tappedFinger      
    end
  end
end
