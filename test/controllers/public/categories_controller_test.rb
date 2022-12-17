require "test_helper"

class Public::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_categories_create_url
    assert_response :success
  end

  test "should get update" do
    get public_categories_update_url
    assert_response :success
  end
end
