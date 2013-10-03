require 'html/pipeline'

class Markdown
	def self.filter(string)
		pipeline = HTML::Pipeline.new [
	    HTML::Pipeline::MarkdownFilter,
	    HTML::Pipeline::EmojiFilter
  	], {asset_root: "https://a248.e.akamai.net/assets.github.com/images/icons"}

		pipeline.to_html(string)
	end
end