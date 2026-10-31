class AddUniqueProviderClientIndexToEnrollments < ActiveRecord::Migration[8.1]
  def change
    add_index :enrollments, [:provider_id, :client_id], unique: true
  end
end
