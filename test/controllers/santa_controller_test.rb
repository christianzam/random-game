require "test_helper"

class SantaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @santum = santa(:one)
  end

  test "should get index" do
    get santa_url
    assert_response :success
  end

  test "should get new" do
    get new_santum_url
    assert_response :success
  end

  test "should create santum" do
    assert_difference('Santum.count') do
      post santa_url, params: { santum: { email: @santum.email, give_to: @santum.give_to, nickname: @santum.nickname, user_id: @santum.user_id } }
    end

    assert_redirected_to santum_url(Santum.last)
  end

  test "should show santum" do
    get santum_url(@santum)
    assert_response :success
  end

  test "should get edit" do
    get edit_santum_url(@santum)
    assert_response :success
  end

  test "should update santum" do
    patch santum_url(@santum), params: { santum: { email: @santum.email, give_to: @santum.give_to, nickname: @santum.nickname, user_id: @santum.user_id } }
    assert_redirected_to santum_url(@santum)
  end

  test "should destroy santum" do
    assert_difference('Santum.count', -1) do
      delete santum_url(@santum)
    end

    assert_redirected_to santa_url
  end
end
