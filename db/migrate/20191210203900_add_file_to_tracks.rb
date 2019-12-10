class AddFileToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :file, :string
  end
end
