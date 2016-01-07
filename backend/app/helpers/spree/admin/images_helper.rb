module Spree
  module Admin
    module ImagesHelper

      def options_text_for(image)
        if image.variants.any?
          image.variants.collect { |v| if v.is_master? then Spree.t(:all_variants) else v.options_text end }.join('<br>').html_safe
        else
          ''
        end
      end

    end
  end
end

