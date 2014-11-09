module NoticesHelper
  def set_step_info(step)
    title = {first: 'draft it', second: 'secure it', third: 'share it'}[step]
    set_title(title)
    set_crumbs(t('navigation.notices') => notices_path, title => url_for)
  end
end
