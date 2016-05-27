require 'rails_helper'

RSpec.describe Hospital, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create ExpectJob" do
    hospital = build(:hospital)
    expect(hospital).to be_valid

  end
end
