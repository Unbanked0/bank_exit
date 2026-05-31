require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'is valid with a compliant password and confirmation' do
    user = User.new(
      email_address: 'john@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )

    assert user.valid?
  end

  test 'requires password on creation' do
    user = User.new(email_address: 'john@example.com')

    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test 'requires password to be at least 8 characters' do
    user = User.new(
      email_address: 'john@example.com',
      password: 'short',
      password_confirmation: 'short'
    )

    assert_not user.valid?
    assert_includes user.errors[:password], 'is too short (minimum is 8 characters)'
  end

  test 'requires password confirmation' do
    user = User.new(
      email_address: 'john@example.com',
      password: 'password123',
      password_confirmation: nil
    )

    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "can't be blank"
  end

  test 'requires matching password confirmation' do
    user = User.new(
      email_address: 'john@example.com',
      password: 'password123',
      password_confirmation: 'different123'
    )

    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "doesn't match Password"
  end

  test 'does not require password when updating unrelated attributes' do
    user = FactoryBot.create(:user)

    user.email_address = 'new@example.com'

    assert user.valid?
  end

  test 'requires confirmation when changing password' do
    user = FactoryBot.create(:user)

    user.password = 'newpassword123'
    user.password_confirmation = nil

    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "can't be blank"
  end

  test 'requires minimum length when changing password' do
    user = FactoryBot.create(:user)

    user.password = 'short'
    user.password_confirmation = 'short'

    assert_not user.valid?
    assert_includes user.errors[:password], 'is too short (minimum is 8 characters)'
  end

  test 'accepts valid password change' do
    user = FactoryBot.create(:user)

    user.password = 'newpassword123'
    user.password_confirmation = 'newpassword123'

    assert user.valid?
  end
end
