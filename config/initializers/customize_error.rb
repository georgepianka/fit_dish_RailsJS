ActionView::Base.field_error_proc = proc { |html_tag, _instance| "<span class=\"field_with_errors\">#{html_tag}</span>".html_safe }
