module ApplicationHelper

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def is_active_actions(action_names)
    action_names.include?(params[:action]) ? "active" : nil
  end

  def is_active_controller_and_action(controller_name, action_name)
    if params[:controller] == controller_name && params[:action] == action_name
      "active"
    else
      nil
    end
  end

  def br(str)
    html_escape(str).gsub(/\r\n|\r|\n/, "<br />").html_safe
  end

  def bookmark_icon(favorite, user)
    if user
      if user.favorites.exists?(post: favorite)
        '<i class="fa fa-bookmark fa-2x"></i>'
      else
        '<i class="fa fa-bookmark fa-bookmark-o fa-2x"></i>'
      end
    end
  end

end

module ActionView
  module Helpers
    module FormHelper

      def flash_error_messages!(flash)
        if flash
          html = <<-HTML
            <div class="alert alert-danger">
              <ul>
                <li>
                  #{flash}
                </li>
              </ul>
            </div>
          HTML

          html.html_safe
        end
      end

      def flash_success_messages!(flash)
        if flash
          html = <<-HTML
            <div class="alert alert-success">
              <ul>
                <li>
                  #{flash}
                </li>
              </ul>
            </div>
          HTML

          html.html_safe
        end
      end

      def error_messages!(object_name, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if !resource || resource.errors.empty?

        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

        html = <<-HTML
          <div class="alert alert-danger">
            <ul>#{messages}</ul>
          </div>
        HTML

        html.html_safe
      end

      def error_css(object_name, method, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if resource.errors.empty?

        resource.errors.include?(method) ? 'has-error' : ''
      end
    end

    class FormBuilder
      def error_messages!(options = {})
        @template.error_messages!(@object_name, options.merge(object: @object))
      end

      def error_css(method, options = {})
        @template.error_css(@object_name, method, options.merge(object: @object))
      end
    end
  end
end
