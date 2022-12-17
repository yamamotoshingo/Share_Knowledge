require "test_helper"

class Public::KnowledgesControllerTest < ActionDispatch::IntegrationTest
  test "should get choose" do
    get public_knowledges_choose_url
    assert_response :success
  end

  test "should get index" do
    get public_knowledges_index_url
    assert_response :success
  end

  test "should get show" do
    get public_knowledges_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_knowledges_edit_url
    assert_response :success
  end

  test "should get new" do
    get public_knowledges_new_url
    assert_response :success
  end

  test "should get create" do
    get public_knowledges_create_url
    assert_response :success
  end

  test "should get update" do
    get public_knowledges_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_knowledges_destroy_url
    assert_response :success
  end
end
