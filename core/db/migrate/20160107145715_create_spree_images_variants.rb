class CreateSpreeImagesVariants < ActiveRecord::Migration
  def change
    create_table :spree_images_variants, id: false do |t|
      t.integer :image_id, null: false
      t.integer :variant_id, null: false
    end

    add_index(:spree_images_variants, :image_id)
    add_index(:spree_images_variants, :variant_id)
  end
end
