require 'html/pipeline'

module Markdown
	def filter(attribute)
		string = self.send(attribute)
		
		pipeline = HTML::Pipeline.new [
	    HTML::Pipeline::MarkdownFilter,
	    HTML::Pipeline::EmojiFilter
  	], {asset_root: "https://a248.e.akamai.net/assets.github.com/images/icons"}

		pipeline.to_html(string)
	end
end