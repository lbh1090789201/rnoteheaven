require 'rails_helper'

RSpec.describe Webapp::ResumeViewsHelper, type: :helper do
  it 'test get_resume_views' do

    user = create :user
    hospital = create(:hospital)
    hospital2 = create(:hospital2)
    resume_view = create :resume_view, :hospital_id => hospital.id, :user_id => user.id
    resume_view2 = create :resume_view2, :hospital_id => hospital2.id, :user_id => user.id

    resume_views = get_resume_views(user.id)
    expect(resume_views.size).to eq 2
  end
end
