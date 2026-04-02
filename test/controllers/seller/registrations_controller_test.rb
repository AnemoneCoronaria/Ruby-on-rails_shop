require "test_helper"

class Seller::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get seller_registrations_new_url
    assert_response :success
  end

  test "should get create" do
    get seller_registrations_create_url
    assert_response :success
  end
end
