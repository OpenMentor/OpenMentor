module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    resource.
      errors.
      full_messages.
      map { |msg| content_tag(:p, msg, class: "alert") }.
      join.
      html_safe
  end
end
