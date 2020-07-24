require 'test_helper'

class Admin::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get admin_user_list_url
    assert_response :success
  end

end
