module LocaleDetection
  protected

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    if allowed_locale?(locale)
      I18n.locale = locale
    else
      I18n.locale = I18n.default_locale
    end
    cookies[:locale] = {
      value:   locale,
      expires: 1.year.from_now
    }
  end

  def allowed_locale?(locale)
    I18n.available_locales.include?(:"#{locale}")
  end
end
