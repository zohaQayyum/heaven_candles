module Admin
  module AdminHelper
    def admin_nav_link(title, path)
      active = request.path.start_with?(path)
      link_to title, path, class: "nav-link #{active ? 'active bg-secondary rounded' : 'text-white'}"
    end
  end
end
