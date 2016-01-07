class UpdateImageVariants < ActiveRecord::Migration
  def change
    # Insere a variante ja atribuida a imagem na lista de variantes
    Spree::Image.all.each do |img|
      if img.viewable.present? and !img.variants.include?(img.viewable)
        img.variants << img.viewable
        img.save
      end
    end
  end
end
