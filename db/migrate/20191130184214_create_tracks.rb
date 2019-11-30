class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.jsonb :artist
      t.string :created_by
      t.string :lyrics

      t.timestamps
    end
  end
end
