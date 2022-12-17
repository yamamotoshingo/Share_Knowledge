require "test_helper"

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_categories_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_categories_destroy_url
    assert_response :success
  end
end
