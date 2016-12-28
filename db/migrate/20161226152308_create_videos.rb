class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.string :description
      t.string :published_at
      t.string :thumbnail_url
      t.string :channel_title
      t.string :channel_id
      t.string :duration

      t.timestamps
    end
  end
end
