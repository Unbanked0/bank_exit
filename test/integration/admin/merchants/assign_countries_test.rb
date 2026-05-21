require 'test_helper'

module Admin
  module Merchants
    class AssignCountriesTest < ActionDispatch::IntegrationTest
      teardown do
        sign_out
      end

      test 'should assign countries when user is super_admin' do
        @user = FactoryBot.create(:user, role: :super_admin)
        sign_in_as(@user)

        post '/admin/merchants/assign_countries'

        assert_equal I18n.t('admin.merchants.assign_countries.create.notice'), flash[:notice]
        assert_redirected_to admin_merchants_path
      end

      test 'should assign countries when user is admin' do
        @user = FactoryBot.create(:user, role: :admin)
        sign_in_as(@user)

        post '/admin/merchants/assign_countries'

        assert_equal I18n.t('admin.merchants.assign_countries.create.notice'), flash[:notice]
        assert_redirected_to admin_merchants_path
      end

      test 'should not assign countries when user is moderator' do
        @user = FactoryBot.create(:user, role: :moderator)
        sign_in_as(@user)

        post '/admin/merchants/assign_countries'

        assert_redirected_to root_path
      end

      test 'should not assign countries when user is not logged in' do
        post '/admin/merchants/assign_countries'

        assert_redirected_to new_session_path
      end
    end
  end
end
