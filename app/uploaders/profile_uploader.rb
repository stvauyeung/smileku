class ProfileUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick
	include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

	version :normal do
		process :resize_to_fill => [250, 250]
	end

	version :preview do
		process :resize_to_fill => [150, 150]
	end

	def default_url
		asset_path("profiles/" + ["blue", "green", "red", "yellow"].sample + ".png")
	end

	def store_dir
		'public/users'
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end