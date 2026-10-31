class Enrollment < ApplicationRecord

  enum :plan, { basic: "basic", premium: "premium" }, validate: { presence: true }

  belongs_to :provider
  belongs_to :client

  validates :client_id, uniqueness: { scope: :provider_id }
end
