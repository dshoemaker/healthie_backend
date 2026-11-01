class JournalEntry < ApplicationRecord
  belongs_to :client

  scope :newest_first, -> { order(created_at: :desc, id: :desc) }
end
