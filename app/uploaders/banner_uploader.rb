class BannerUploader < CarrierWave::Uploader::Base
  # delete empty folder after remove uploaded files
  after :remove, :delete_empty_upstream_dirs

  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_by_use_type

  version :thumb do
    process resize_to_fill: [128, 128]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    @name ||= "#{timestamp}-#{secure_token(8)}.#{file.extension}" if original_filename.present?
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

  protected

  def resize_by_use_type
    return resize_to_fill(720, 1290) if model.respond_to?('sign_up?') && model.sign_up?

    resize_to_fill(1920, 660)
  end

  def for_sign_up?(new_file)
    model.sign_up?
  end

  def not_for_sign_up?(new_file)
    !for_sign_up?(new_file)
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) || model.instance_variable_set(var, Time.current.strftime('%Y_%m_%d_%H_%M'))
  end

  def secure_token(length = 16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(length / 2))
  end
end
