class PostMrecUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick

	process :resize_to_fill => [300, 250]

	def store_dir
		'public/posts/mrec'
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end