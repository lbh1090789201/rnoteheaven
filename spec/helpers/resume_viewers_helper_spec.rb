require 'rails_helper'

RSpec.describe Webapp::ResumeViewersHelper, type: :helper do

    describe 'test get_resume_viewers' do
      before :each do
        @user = create :user
        @hospital = create(:hospital)
        @hospital2 = create(:hospital2)
        @resume_view = create :resume_viewer, :hospital_id => @hospital.id, :user_id => @user.id
        @resume_view2 = create :resume_viewer, :hospital_id => @hospital2.id, :user_id => @user.id
      end

      it 'test get_resume_viewers' do
        resume_viewers = get_resume_viewers(@user.id)
        expect(resume_viewers.size).to eq 2
      end

    end

end
