require "test_helper"

class CockpitControllerTest < ActionDispatch::IntegrationTest
  test "renders the cockpit" do
    get root_url

    assert_response :success
    assert_select "turbo-frame#cockpit"
    assert_select "h1", "チームスキル・コックピット"
  end
end
