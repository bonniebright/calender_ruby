class Event < ActiveRecord::Base
  belongs_to :user

  def start_formatted_date
    self.start_date_time.strftime('%m-%d-%Y at %I:%M%p')
  end

  def end_formatted_date
    self.end_date_time.strftime('%m-%d-%Y at %I:%M%p')
  end

end
