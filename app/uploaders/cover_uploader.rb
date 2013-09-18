class CoverUploader < CarrierWave::Uploader::Base
	def store_dir
		'public/tmp/uploads'
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end