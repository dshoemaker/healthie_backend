require "test_helper"

class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enrollment = enrollments(:basic)
  end

  test "should get index" do
    get enrollments_url
    assert_response :success
  end

  test "should get new" do
    get new_enrollment_url
    assert_response :success
  end

  test "should create enrollment" do
    assert_difference("Enrollment.count") do
      post enrollments_url, params: {
        enrollment: {
          provider_id: providers(:simon).id,
          client_id: clients(:nash).id,
          plan: "basic"
        }
      }
    end

    assert_redirected_to enrollment_url(Enrollment.last)
  end

  test "should show enrollment" do
    get enrollment_url(@enrollment)
    assert_response :success
  end

  test "should get edit" do
    get edit_enrollment_url(@enrollment)
    assert_response :success
  end

  test "should update enrollment" do
    patch enrollment_url(@enrollment), params: { enrollment: { client_id: @enrollment.client_id, plan: @enrollment.plan, provider_id: @enrollment.provider_id } }
    assert_redirected_to enrollment_url(@enrollment)
  end

  test "should destroy enrollment" do
    assert_difference("Enrollment.count", -1) do
      delete enrollment_url(@enrollment)
    end

    assert_redirected_to enrollments_url
  end
end
