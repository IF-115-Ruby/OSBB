CarrierWave.configure do |config|

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end

  config.fog_credentials = {
    provider: 'AWS', # required
    aws_access_key_id: ENV["AWS_ACCESS_KEY"],            # required
    aws_secret_access_key: ENV["AWS_SECRET_KEY"],        # required
    region: 'us-east-1',
    path_style: true
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_public = false
  config.fog_directory = ENV["AWS_BUCKET"]
end
