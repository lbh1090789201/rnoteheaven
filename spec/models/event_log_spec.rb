require 'rails_helper'

RSpec.describe EventLog, type: :model do
  it "test event_logs create_log" do
    res = create(:event_log)
    expect(res).to be_valid
  end
end
