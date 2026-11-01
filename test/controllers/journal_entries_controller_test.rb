require "test_helper"

class JournalEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @journal_entry = journal_entries(:one)
  end

  test "should get index" do
    get journal_entries_url
    assert_response :success
  end

  test "index lists journal entries by most recent" do
    older = journal_entries(:one)
    newer = journal_entries(:two)

    older.update!(created_at: 2.days.ago)
    newer.update!(created_at: 1.day.ago)

    get journal_entries_url

    assert_response :success
    assert_select "#journal_entries > div[id]" do |entries|
      assert_equal [
        "journal_entry_#{newer.id}",
        "journal_entry_#{older.id}"
      ], entries.map { |entry| entry["id"] }
    end
  end

  test "should get new" do
    get new_journal_entry_url
    assert_response :success
  end

  test "should create journal_entry" do
    assert_difference("JournalEntry.count") do
      post journal_entries_url, params: { journal_entry: { body: @journal_entry.body, client_id: @journal_entry.client_id } }
    end

    assert_redirected_to journal_entry_url(JournalEntry.last)
  end

  test "should show journal_entry" do
    get journal_entry_url(@journal_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_journal_entry_url(@journal_entry)
    assert_response :success
  end

  test "should update journal_entry" do
    patch journal_entry_url(@journal_entry), params: { journal_entry: { body: @journal_entry.body, client_id: @journal_entry.client_id } }
    assert_redirected_to journal_entry_url(@journal_entry)
  end

  test "should destroy journal_entry" do
    assert_difference("JournalEntry.count", -1) do
      delete journal_entry_url(@journal_entry)
    end

    assert_redirected_to journal_entries_url
  end
end
