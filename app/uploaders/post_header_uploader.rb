class PostHeaderUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick

	process :resize_to_fill => [600, 220]

	def store_dir
		'public/posts/headers'
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end