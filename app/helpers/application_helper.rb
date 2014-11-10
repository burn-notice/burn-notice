module ApplicationHelper
  def form_errors(model)
    if model.errors.present?
      content_tag(:ul, class: 'well errors') do
        model.errors.full_messages.each do |message|
          concat content_tag(:li, message, class: 'text-danger')
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

  def title(default = 'Burn-Notice')
    parts = [default]
    parts << content_for(:title) if content_for?(:title)
    parts.join(' / ')
  end

  def markdown(text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    @markdown.render(text)
  end

  PROVIDERS = {
    twitter: 'Twitter',
    github: 'GitHub',
    facebook: 'Facebook',
    google_oauth2: 'Google',
    email: 'E-Mail',
  }

  def login_links
    PROVIDERS.each do |provider, name|
      path = "/auth/#{provider}"
      yield(name, path, provider.to_s)
    end
  end
end