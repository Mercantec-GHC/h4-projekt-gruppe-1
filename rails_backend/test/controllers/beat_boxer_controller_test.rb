require "test_helper"

class BeatBoxerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get beat_boxer_show_url
    assert_response :success
  end

  test "should get create" do
    get beat_boxer_create_url
    assert_response :success
  end

  test "should get delete" do
    get beat_boxer_delete_url
    assert_response :success
  end
end
