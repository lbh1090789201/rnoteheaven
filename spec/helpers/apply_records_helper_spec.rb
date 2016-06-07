require 'rails_helper'

RSpec.describe Webapp::ApplyRecordsHelper, type: :helper do

  describe "user apply_recoard_helper" do
    before :each do
      @user = create :user
      @job = create :job
      @job2 = create :job2
      @hospital = create :hospital, id: @job.hospital_id
      @hospital2 = create :hospital, id: @job2.hospital_id
      @apply_record = create(:apply_record, user_id: @user.id, job_id: @job.id)
      @apply_record2 = create(:apply_record, user_id: @user.id, job_id: @job2.id)
    end

    it 'test get_apply_records' do
      res = get_apply_records(@user.id)
      expect(res.size).to eq 2
    end

  end

end
