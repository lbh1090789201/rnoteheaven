require 'rails_helper'

RSpec.describe Webapp::ApplyRecordsHelper, type: :helper do

  it 'test get_apply_records' do
    apply_record = create(:apply_record)
    apply_record2 = create(:apply_record2)
    job = create(:job)
    job2 = create(:job2)

    res = get_apply_records(1)
    expect(res.size).to eq 2
  end

end
