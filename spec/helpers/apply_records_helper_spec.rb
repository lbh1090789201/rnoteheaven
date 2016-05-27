require 'rails_helper'

RSpec.describe Webapp::ApplyRecordsHelper, type: :helper do
  it 'test get_apply_records ' do
    apply_record = create(:apply_record)

    user = get_apply_records(1)
    expect(apply_record.resume_status).to eq "MyString"
  end
  # it 'test get_job_infos ' do
  #   job = create(:job)
  #
  #   user = get_job_infos(1)
  #   expect(apply_record.resume_status).to eq "MyString"
  # end
end
