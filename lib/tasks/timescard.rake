namespace :timecards do
  desc "TODO"
  task :updateCache => :environment do
    puts "Getting user's time in lab"
    
    i = 1
    User.all.each do |user|
      puts "User #{i} of #{User.all.count}"
      user.timeInLab(DateTime.now.year)
      user.timeInLab(DateTime.now.year-1)
      i = i+1
    end

    puts "Getting everyone's time in lab"    
    TimeEntry.timeInLabByDateData(DateTime.now.year)
    TimeEntry.timeInLabByDateData(DateTime.now.year-1)
  end

end
