class ImageUploader < BaseUploader

  def store_dir
    super
    "uploads/user/#{mounted_as}/#{id_partition}/#{model.id}"
  end

  def default_url
    "/img/user/" + [version_name, "default_user_image.jpg"].compact.join('_')
  end

  version :thumb do
    process resize_to_fill: [375, 300]
  end

  version :square do
    process resize_to_fill: [300, 300]
  end

  version :nav_thumb do
    process resize_to_fill: [100,100]
  end
end
