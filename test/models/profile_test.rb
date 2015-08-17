require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
   test "should get show" do
    get :show, id: users(:mannie).username
    assert_response :success
    assert_template 'profiles/show'
  end

  test "should render a 404 on profile not found" do
    get :show, id: "doesn't exist"
    assert_response :not_found
  end
end
