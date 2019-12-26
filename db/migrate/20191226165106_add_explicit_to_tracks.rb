class AddExplicitToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :explicit, :boolean
  end
end
