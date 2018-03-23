# Admin
crumb :admin_root do
  link 'Home', admin_root_path, icon: 'fa-home'
end

crumb :admin_dashboard do
  link I18n.t('page_titles.admin.dashboard.main_title'), admin_dashboard_path, icon: 'fa-tachometer'
  parent :admin_root
end

crumb :admin_admins do
  link I18n.t('page_titles.admin.admins.main_title'), admin_admins_path, icon: 'fa-user-md'
  parent :admin_root
end

crumb :admin_admin do |admin|
  link I18n.t('page_titles.admin.admins.show'), admin_admin_path(admin), icon: 'fa-search'
  parent :admin_admins
end

crumb :admin_users do
  link I18n.t('page_titles.admin.users.main_title'), admin_admins_path, icon: 'fa-users'
  parent :admin_root
end

crumb :admin_product_categories do
  link I18n.t('page_titles.admin.product_categories.main_title'), admin_product_categories_path, icon: 'fa-folder-open'
  parent :admin_root
end

crumb :admin_system_config do
  link I18n.t('page_titles.admin.system_config.main_title'), admin_admins_path, icon: 'fa-gears'
  parent :admin_root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
