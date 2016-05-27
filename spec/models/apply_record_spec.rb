require 'rails_helper'

RSpec.describe ApplyRecord, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create apply_record" do
    apply_record = create(:apply_record)
    expect(apply_record).to be_valid

  end
end
