require "test_helper"

class UserStatControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_stat_show_url
    assert_response :success
  end

  test "should get index" do
    get user_stat_index_url
    assert_response :success
  end

  test "should get new" do
    get user_stat_new_url
    assert_response :success
  end

  test "should get create" do
    get user_stat_create_url
    assert_response :success
  end
end
