module ApplicationHelper

  def show_errors model
    if model.errors.any?
      messages = model.errors.full_messages.map { |message| "<li class='error'>#{message}</li>" }
      %Q(
        <div id="error_explanation">
          <ul>
            #{messages.join("")}
          </ul>
        </div>
      ).html_safe
    end
  end

end
