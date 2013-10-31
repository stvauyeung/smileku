CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AWS_KEY'],                        # required
      :aws_secret_access_key  => ENV['AWS_SECRET'],                        # required
    }
    config.fog_directory  = Rails.env.production? ? 'smileku' : 'smileku-staging'       # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end