module JavascriptHelper

  def javascript_try_catch(string_contents = nil, &block)
    str = block_given? ? capture(&block) : string_contents
    if Rails.env ==  'production'
      "\ntry{\n#{str}\n} catch(e){ console.log(e.toString()); }\n".html_safe
    else
      "\n#{str}\n".html_safe
    end
  end

  def javascript_closure(string_contents = nil, &block)
    str = block_given? ? capture(&block) : string_contents
    "\n(function(){#{javascript_try_catch(str)}})();\n".html_safe
  end

  def javascript_flashes
    [ :failure, :error, :alert, :warning, :success, :notice ].select{|k| flash[k] }.collect do |k|
      "$.flash('#{k}','#{flash[k]}', ( typeof(flashInstanceDefaults) != 'undefined' ? flashInstanceDefaults : {} ));"
    end.join(' ').html_safe
  end

  def javascript_init_on_ready
    content_for(:javascript, javascript_flashes)
    if content_for?(:javascript)
      javascript_tag "$(function(){#{javascript_try_catch(content_for(:javascript) || '')}});"
    end
  end

end