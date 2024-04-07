module ApplicationHelper
  def error_messages_for(object)
    render(partial: "layouts/error_messages", locals: {object: object})
  end

  def status_tag(boolean, options={})
    options[:true_text] ||= ""
    options[:false_text] ||= ""
    if boolean
      content_tag(:i, options[:true_text], class: "fa-regular fa-circle-check true")
    else
      content_tag(:i, options[:false_text], class: "fa-regular fa-circle-xmark false")
    end
  end
end
