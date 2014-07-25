class Api::TimeloggingController < ApplicationController
  def fingerScanned
    users = User.where(:fingerprint_id => params[:fingerprint_id])
    
    # Check user exists
    if users.count == 0
      render :text => "Get Sam (UNF)"
      return
    else
      # Set user
      user = users.first
      # Update timecard
      render :text => user.tappedFinger      
    end
  end
end
