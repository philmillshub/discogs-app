require "test_helper"

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get suggest" do
    get records_suggest_url
    assert_response :success
  end
end
