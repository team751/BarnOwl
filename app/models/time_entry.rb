class TimeEntry
  include Mongoid::Document
  field :user_id, type: String
  field :clock_in_time, type: DateTime
  field :clock_out_time, type: DateTime
  
  belongs_to :user
  
  def duration
    if clock_out_time
      clock_out_time.to_i-clock_in_time.to_i
    else
      DateTime.now.to_i-clock_in_time.to_i
    end
  end
  
  def self.timeInLabByDateData(year)
    output = ""
    endDate = DateTime.now.to_date
    if Date.new(year+1, 01, 01) < endDate
      endDate = Date.new(year+1, 01, 01)
    end
    (Date.new(year, 01, 01)..endDate).each do |date|
      total = 0
      TimeEntry.where(:clock_in_time => date.midnight..(date.midnight+24.hours)).each do |te|
        total = total+(te.duration)/60.0
      end
      if date == Date.new(2015, 01, 01)
        output = "#{output} ['#{date}', #{total}]"        
      else
        output = "#{output} ['#{date}', #{total}],"
      end
    end
    
    output
  end
end
