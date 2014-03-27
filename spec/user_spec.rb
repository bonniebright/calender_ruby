require "spec_helper"

describe User do
  it "has many events" do
  new_user = User.create(:name => "Bob White")
  new_event = Event.create(:description => "Go to the Moon", :user_id => new_user.id)
  new_user.events.should eq [new_event]
  end
end
