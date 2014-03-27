require 'spec_helper'

describe Event do
  it "should belong to a user" do
    new_user = User.create(:name => "Bob White")
    new_event = Event.create(:description => "Go to the Moon", :user_id => new_user.id)
    new_user.events.should eq [new_event]
  end
  it 'should format the date as MM-DD-YYYY' do
    new_event = Event.create(:start_date_time => '2014-03-25 04:40', :end_date_time => '2014-03-25 04:50')
    new_event.start_formatted_date.should eq '03-25-2014 at 04:40AM'
    new_event.end_formatted_date.should eq '03-25-2014 at 04:50'
  end
end

