require "test_helper"

class ContactPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get contact_pages_show_url
    assert_response :success
  end
end
