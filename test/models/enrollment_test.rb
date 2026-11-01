require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  test "accepts basic and premium plans" do
    enrollment = enrollments(:basic)

    ["basic", "premium"].each do |plan|
      enrollment.plan = plan
      assert enrollment.valid?, enrollment.errors.full_messages.join(", ")
      enrollment.update!(plan: plan)
      assert_equal plan, enrollment.reload.plan
    end
  end

  test "rejects invalid and missing plans" do
    enrollment = enrollments(:basic)

    ["enterprise", nil, ""].each do |plan|
      enrollment.plan = plan

      assert_not enrollment.valid?
      assert_includes enrollment.errors[:plan], "is not included in the list"
    end
  end

  test "rejects a duplicate provider-client pair" do
    existing = enrollments(:basic)

    duplicate = Enrollment.new(
      provider: existing.provider,
      client: existing.client,
      plan: "premium"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:client_id], "has already been taken"
  end
end
