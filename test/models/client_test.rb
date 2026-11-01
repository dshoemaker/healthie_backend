require "test_helper"

require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "returns all providers for a client" do
    crosby = clients(:crosby)
    crosby.enrollments.create!(
      provider: providers(:garfunkle),
      plan: "premium"
    )

    assert_equal(
      [providers(:simon).id, providers(:garfunkle).id].sort,
      crosby.providers.pluck(:id).sort
    )
  end

  test "returns its journal entries newest first" do
    crosby = clients(:crosby)

    older = journal_entries(:one)
    older.update!(created_at: Time.utc(2026, 1, 1))

    newer = crosby.journal_entries.create!(
      body: "Crosby's newer entry",
      created_at: Time.utc(2026, 1, 2)
    )

    journal_entries(:two).update!(created_at: Time.utc(2026, 1, 3))

    assert_equal(
      [newer.id, older.id],
      crosby.journal_entries.newest_first.pluck(:id)
    )
  end
end
