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

  def list_title title
    %Q(
      <h2 class="text-center mt-3">
        #{title}
      </h2>
      <hr>).html_safe
  end

end
