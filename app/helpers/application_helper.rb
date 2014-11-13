module ApplicationHelper

def glyph(*names)
    content_tag :i, nil, :class => names.map{|name| "fa fa-#{name.to_s.gsub('_','-')}" }
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      alert_type = bootstrap_class_for type
      text = content_tag(:div,
                         content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert", "aria-hidden"=>"true") +
                         message, :class => "alert fade in #{alert_type} alert-dismissable")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-warning"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end

end
