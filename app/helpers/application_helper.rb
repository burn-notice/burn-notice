module ApplicationHelper
  def form_errors(model)
    if model.errors.present?
      content_tag(:ul) do
        model.errors.full_messages.each do |message|
          concat content_tag(:li, message)
        end
      end
    end
  end

  def title
    content_for(:title) || 'Burn-Notice'
  end
end
