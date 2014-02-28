module HtmlPageHelper

  # This is a bit counter intuitive. Because views are contructed
  # in a manner that build the layout last we have to prepend the content
  # so the layouts declarations appear first
  def prepend_content_for(name, content = nil, &block)
    @view_flow.set(name, ( content || capture(&block) ) + @view_flow.get(name))
  end

  def head(content = nil, &block)
    prepend_content_for :head, content, &block
  end

  def foot(content = nil, &block)
    prepend_content_for :foot, content, &block
  end

  def javascript(content = nil, &block) 
    prepend_content_for :javascript, content, &block
  end

  def body_classes
    str = "#{controller_name}-section #{controller_name}-page-#{action_name} #{content_for(:body_classes)}"
    str.split(' ').compact().join(' ').gsub(/_/,'-')
  end

end