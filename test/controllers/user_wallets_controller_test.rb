require "test_helper"

class UserWalletsControllerTest < ActionDispatch::IntegrationTest
  test "should get deposit" do
    get user_wallets_deposit_url
    assert_response :success
  end

  test "should get withdraw" do
    get user_wallets_withdraw_url
    assert_response :success
  end
end
