require "test_helper"

require "test_helper"

class ProviderTest < ActiveSupport::TestCase
  test "returns all clients for a provider" do
    simon = providers(:simon)
    simon.enrollments.create!(client: clients(:nash), plan: "basic")

    assert_equal(
      [clients(:crosby).id, clients(:nash).id].sort,
      simon.clients.pluck(:id).sort
    )
  end

  test "returns its clients journal entries newest first" do
    simon = providers(:simon)
    simon.enrollments.create!(client: clients(:nash), plan: "basic")

    older = journal_entries(:one)
    older.update!(created_at: Time.utc(2026, 1, 1))

    newer = clients(:nash).journal_entries.create!(
      body: "Nash's entry",
      created_at: Time.utc(2026, 1, 2)
    )

    journal_entries(:two).update!(created_at: Time.utc(2026, 1, 3))

    assert_equal(
      [newer.id, older.id],
      simon.journal_entries.newest_first.pluck(:id)
    )
  end
end
