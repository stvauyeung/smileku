require 'html/pipeline'

class HtmlPipeline
	def HtmlPipeline.filter(string)
		filter = HTML::Pipeline::MarkdownFilter.new(string)
		filter.call
	end
end