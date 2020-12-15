module ApplicationHelper
  def render_markdown(markdown)
    Kramdown::Document.new(markdown, parse_block_html: true).to_html 
  end 

  # flash classes overriden with boostrap styles 
    def flash_class(level)
        case level
            when :notice then "alert alert-info"
            when :success then "alert alert-success"
            when :error then "alert alert-error"
            when :alert then "alert alert-error"
        end
    end
  end
end
