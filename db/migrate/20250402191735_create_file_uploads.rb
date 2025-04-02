class CreateFileUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.text :file_data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
