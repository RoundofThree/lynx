module ApplicationHelper
  def render_markdown(markdown)
    Kramdown::Document.new(markdown, parse_block_html: true).to_html 
  end 

  def serialize(arr)
    arr.join(",")
  end 

  def deserialize(input)
    if input.blank?
      []
    else
      input.split(/\s*,\s*/)
    end 
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
