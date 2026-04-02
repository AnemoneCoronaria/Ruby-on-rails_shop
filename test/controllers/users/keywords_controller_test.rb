require "test_helper"

class Users::KeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get users_keywords_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_keywords_update_url
    assert_response :success
  end
end
