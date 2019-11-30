require 'rails_helper'

RSpec.describe Track, type: :model do
    # Association test
  # ensure Todo model has a m:1 relationship with the User model
  it { should belong_to(:user) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
