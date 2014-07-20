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

  def set_title(title)
    content_for(:title, title)
  end

  def set_crumbs(crumbs = {})
    @crumbs = crumbs
  end

  def title
    parts = ['Burn-Notice']
    parts << content_for(:title) if content_for?(:title)
    parts.join(' / ')
  end

  def markdown(text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    @markdown.render(text)
  end
end
