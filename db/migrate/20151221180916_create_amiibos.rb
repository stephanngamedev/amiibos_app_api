class CreateAmiibos < ActiveRecord::Migration[5.0]
  def change
    create_table :amiibos do |t|
      t.string :name
      t.integer :series_id
      t.string :release_date
      t.integer :company_id
      t.text :description
      t.string :detail_image_url
      t.string :boxart_image_url

      t.timestamps
    end
  end
end
