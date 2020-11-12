module ApplicationHelper
  def breadcrumbs(links = [])
    content_for :breadcrumbs do
      render 'account/shared/breadcrumbs', links: links
    end
  end
end
