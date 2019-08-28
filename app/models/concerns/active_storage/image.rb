module ActiveStorage
  module Image
    extend ActiveSupport::Concern
    included do
      def correct_image_type
        errors.add(:image, 'Image must be a jpeg,png or gif') if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      end

      def large
        image.variant(resize: '800x800')
      end

      def medium
        image.variant(resize: '500x500')
      end

      def thumbnail
        image.variant(resize: '50x50')
      end
    end
  end
end
