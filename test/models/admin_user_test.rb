require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  test 'user_administrator? when administrator' do
    user = build(:admin_user, :administrator)
    assert user.user_administrator?
  end

  test 'user_administrator? when not administrator' do
    user = build(:admin_user, :supervisor)
    assert_not user.user_administrator?
  end

  test 'user_supervisor? when administrator' do
    user = build(:admin_user, :administrator)
    assert_not user.user_supervisor?
  end

  test 'user_supervisor? when supervisor' do
    user = build(:admin_user, :supervisor)
    assert user.user_supervisor?
  end
end
