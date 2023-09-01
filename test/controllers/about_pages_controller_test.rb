require "test_helper"

class AboutPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get about_pages_show_url
    assert_response :success
  end
end
