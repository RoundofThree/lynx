module ApplicationHelper
  def render_markdown(markdown)
    Kramdown::Document.new(markdown, parse_block_html: true).to_html
  end

  def serialize(arr)
    arr.join(',')
  end

  def deserialize(input)
    input.split(/\s*,\s*/) unless input.blank?
  end

  # flash classes overriden with boostrap styles
  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-danger'
    end
  end
end
