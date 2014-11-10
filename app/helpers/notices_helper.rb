module NoticesHelper
  def set_step_info(step)
    title = {first: t('notices.draft_it'), second: t('notices.secure_it'), third: t('notices.share_it')}[step]
    set_title title
    set_crumbs t('navigation.notices') => notices_path, title => url_for
  end
end
