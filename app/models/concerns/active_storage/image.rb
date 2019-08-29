module ActiveStorage
  module Image
    extend ActiveSupport::Concern
    included do
      def correct_image_type
        errors.add(:image, 'must be a jpeg,png or gif') if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      end

      def user_image_type
        errors.add(:avatar, 'must be a jpeg or png') if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png])
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

      def avatar
        image.variant(resize: '40x40')
      end
    end
  end
end
