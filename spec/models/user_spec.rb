require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }

  before do
    create(:user)
  end

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of(:full_name) }
  it { should validate_length_of(:full_name).is_at_least(3).is_at_most(50) }

  it { should validate_length_of(:password).is_at_least(6) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }
end
