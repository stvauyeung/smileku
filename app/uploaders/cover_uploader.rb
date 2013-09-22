class CoverUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick

	process :resize_to_fill => [400, 400]

	version :preview do
		process :resize_to_fill => [200, 200]
	end

	def store_dir
		'public/tmp/uploads'
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end