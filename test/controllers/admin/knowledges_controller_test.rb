require "test_helper"

class Admin::KnowledgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_knowledges_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_knowledges_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_knowledges_destroy_url
    assert_response :success
  end
end
