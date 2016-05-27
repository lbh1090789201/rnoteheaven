require 'rails_helper'

# include Webapp::ApplyRecordsHelper
RSpec.describe Webapp::ApplyRecordsHelper, type: :helper do
  it 'test get_apply_records ' do
    user = get_apply_records(1)
    expect(user).to eq []
  end
end
