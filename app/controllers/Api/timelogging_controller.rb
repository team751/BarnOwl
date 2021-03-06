class Api::TimeloggingController < ApplicationController
  def fingerScanned
    users = User.where(:fingerprint_id => params[:fingerprint_id])
    
    # enrolledUsers = User.where(:enroll => true)
    # if enrolledUsers.count > 0
    #   
    #   # Check user exists
    #   if users.count > 0
    #     # Set user
    #     user = users.first
    # 
    #     if user.roles.include? "admin"
    #       render :json => "enroll"
    #       return
    #     end   
    #   end
    #   
    #   user = enrolledUsers.first
    #   user.fingerprint_id = params[:fingerprint_id]
    #   user.enroll = false
    #   user.save
    #   
    #   render :json => "Hello #{user.first_name}. You can now clock in and out using the fingerprint reader."
    #   return
    # end
    #     
    # if params[:enroll]
    #   render :json => "In enroll mode"
    #   return
    # end
        
    # Check user exists
    if users.count == 0
      render :json => "Get Sam (UNF)"
      return
    else
      # Set user
      user = users.first
      # Update timecard
      render :json => user.tappedFinger      
    end
  end
end
