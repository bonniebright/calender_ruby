require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(test_configuration)


def welcome_menu
  puts "Welcome to CALENDAR CRAZE"
  puts "Or press 'l' to login to your account or 'x' to exit"
  user_input = gets.chomp.downcase
  case user_input
  when 'l'
    find_user
  when 'x'
    puts "Goodbye!!!"
  else
    puts "Not a valid option! Try again"
    welcome_menu
  end
end

def find_user
  puts "Please type in your name:"
  name = gets.chomp
  @user = User.find_or_create_by(name: name)
  puts "#{@user.name} is logged in."
  user_menu
end

# def new_user

#   puts "Please type in your name to create account:"
#   name = gets.chomp
#   @user = User.create(:name => name)
#   puts "#{@user.name} is logged in."
#   user_menu
# end

def user_menu
  puts "~~~~Calendar Menu~~~~~"
  puts "Press 'a' to add an event to a calendar"
  puts "Press 'l' to go list events"
  puts "Press 'x' to exit the calendar"
  user_input = gets.chomp.downcase
  case user_input
  when 'a'
    add_event
  when 'l'
    list_events_menu
  when 'x'
    puts "Seya!"
  else
    puts "Not a valid input"
    user_menu
  end
end

def add_event
  input_hash = {:user_id => @user.id}
  puts "Please enter the description of the event"
  input_hash[:description] = gets.chomp
  puts "Please enter a location for the event"
  input_hash[:location] = gets.chomp
  puts "Please enter a date and time for the event, if there is no start time, leave blank"
  input_hash[:start_date_time] = gets.chomp
  puts "Enter an ending date and time for your event, if no end date, leave blank ex format: yyyy-mm-dd "
  input_hash[:end_date_time] = gets.chomp
  new_event = Event.create(input_hash)
  puts "You added #{new_event.description} at #{new_event.location} starting on #{new_event.start_formatted_date} ending on #{new_event.end_formatted_date}"
  user_menu
end

def list_events_menu
  puts "To see your calender for today, press 'd'"
  puts "press 'w' to see the current week"
  puts "'m' to see the current month or"
  puts "'l' to see all your events."
  user_input = gets.chomp
  case user_input
  when 'd'
    list_day
  when 'w'
    list_week
  when 'm'
    list_month
  when 'l'
    list_events
  end
end

def list_day
  events = @user.events.where start_date_time: current_day
  events.each do |event|
    puts "\n\n{event.description} at #{event.location} which starts at #{event.start_formatted_date} and ends at #{event.end_formatted_date}.\n\n"
  end
  list_events_menu
end

def list_week
  events = @user.events.where start_date_time: current_week
  events.each do |event|
    puts "\n\n#{event.description} at #{event.location} which starts at #{event.start_formatted_date} and ends at #{event.end_formatted_date}.\n\n"
  end
  list_events_menu
end

def list_month
  events = @user.events.where start_date_time: current_month
  events.each do |event|
    puts "\n\n#{event.description} at #{event.location} which starts at #{event.start_formatted_date} and ends at #{event.end_formatted_date}.\n\n"
  end
  list_events_menu
end

def list_events
  events = @user.events.order(:start_date_time)
  events.each do |event|
    puts "\n\n#{event.description} at #{event.location} which starts at #{event.start_formatted_date} and ends at #{event.end_formatted_date}.\n\n"
  end
end

def current_day
  Time.now.beginning_of_day..Time.now.end_of_day
end

def current_week
  Time.now.beginning_of_day..Time.now.end_of_week
end

def current_month
  Time.now.beginning_of_day..Time.now.end_of_month
end

welcome_menu
