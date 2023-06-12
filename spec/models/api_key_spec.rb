require 'rails_helper'

describe ApiKey, type: :model do
  describe 'associations' do
    it { should belong_to :bearer }
  end
end
