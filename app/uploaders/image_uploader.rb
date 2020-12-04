class ImageUploader < AvatarUploader
  version :image_show do
    process resize_to_fill: [700, 300]
  end
end
