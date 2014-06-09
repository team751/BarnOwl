class Ps < ActionMailer::Base
  default from: "sbaumgarten@makrr.com"
  
  def email(resource, params)
    @resource = resource
    @params = params
    mail(to: "sambaumgarten98@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
