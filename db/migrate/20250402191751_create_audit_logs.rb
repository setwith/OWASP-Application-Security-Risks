class CreateAuditLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :audit_logs do |t|
      t.string :activity
      t.references :user, null: false, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
