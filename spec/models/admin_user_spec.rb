require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'user_administrator?' do
    it 'when administrator' do
      user = build(:admin_user, :administrator)
      expect(user.user_administrator?).to be true
    end

    it 'when not administrator' do
      user = build(:admin_user, :supervisor)
      expect(user.user_administrator?).to be false
    end
  end

  describe 'user_supervisor?' do
    it 'when administrator' do
      user = build(:admin_user, :administrator)
      expect(user.user_supervisor?).to be false
    end

    it 'user_supervisor? when supervisor' do
      user = build(:admin_user, :supervisor)
      expect(user.user_supervisor?).to be true
    end
  end
end
