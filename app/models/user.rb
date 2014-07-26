class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include User::AuthDefinitions
  include User::Roles

  field :email, type: String
  field :image, type: String
  field :fingerprint_id, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :password_reset, type: Boolean
  field :enroll, type: Boolean
  field :roles_mask, type: Integer
  
  validates_presence_of :email, :first_name, :last_name
  
  has_many :identities
  has_many :timeEntries
  has_and_belongs_to_many :certifications
  
  def enableEnroll
    User.all.each do |u|
      u.update_column(:enroll, false)
    end
    
    update_column(:enroll, true)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def timeInLab(year)
    combination = 0
    (Date.new(year, 01, 01)..Date.new(year+1, 01, 01)).each do |date|
      total = 0
      timeEntries.where(:clock_in_time => date.midnight..(date.midnight+24.hours)).each do |te|
        total = total+te.duration
      end
      combination = combination+total
    end
    
    combination
  end
  
  def clock_in
    return if isInLab?
    timeentry = TimeEntry.new
    timeentry.user = self
    timeentry.clock_in_time = DateTime.now
    if timeentry.save
      return "#{first_name} checked in"
    else
      return "try again"
    end
  end
  
  def clock_out
    return if !isInLab?
    timeentry = timeEntries.last
    timeentry.clock_out_time = DateTime.now
    if timeentry.save
      return "#{first_name} checked out"
    else
      return "try again"
    end
  end
  
  def tappedFinger
    if isInLab?
      clock_out
    else
      clock_in
    end
  end
  
  def timeInLabSince(startDate, responseType)
    total = 0
    records = timeEntries.where(:clock_in_time => startDate..DateTime.now)
    records.each do |timeentry|
      total = total+timeentry.duration
    end
    
    case responseType
      when :seconds
        total
      when :minutes
        total/60.0
      when :hours
        total/3600.0
      when :days
        total/86400.0
      end
  end
  
  def isInLab?
    if timeEntries.count == 0
      return false
    end
    timeEntries.last.clock_out_time == nil
  end

end
