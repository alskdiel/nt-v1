require 'test_helper'

class ReviewHousesControllerTest < ActionController::TestCase
  setup do
    @review_house = review_houses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:review_houses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create review_house" do
    assert_difference('ReviewHouse.count') do
      post :create, review_house: {  }
    end

    assert_redirected_to review_house_path(assigns(:review_house))
  end

  test "should show review_house" do
    get :show, id: @review_house
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @review_house
    assert_response :success
  end

  test "should update review_house" do
    patch :update, id: @review_house, review_house: {  }
    assert_redirected_to review_house_path(assigns(:review_house))
  end

  test "should destroy review_house" do
    assert_difference('ReviewHouse.count', -1) do
      delete :destroy, id: @review_house
    end

    assert_redirected_to review_houses_path
  end
end
