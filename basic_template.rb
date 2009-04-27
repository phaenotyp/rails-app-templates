run "echo TODO > README"

generate :nifty_layout

# GEMS
gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
rake "gems:install"
# Plugins 
plugin 'aasm' :git => 'git:github.com/rubyist/aasm.git'



if yes?('Restful Authenticate benutzen?')
  plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git'

  generate("authenticated", "user session --include-activation --aasm")

  route "map.resources :users, :member => { :activate => :get,
					:suspend => :put,
					:unsuspend => :put,
					:purge => :delete}"

  route "map.resource :login, :controller => 'login'"
  route "map.activate '/activate/:activation_code', :controller => 'users',
		:action => 'activate', :activation_code => 'nil'"
  route "map.signup   '/signup', :controller => 'users', :action => 'new'"
  route "map.login    '/login',  :controller => 'login', :action => 'new'"
  route "map.logout   '/logout', :controller => 'login', :action => 'destroy'"
end

if yes?("Role Requirement benutzen?")
# Rollenverwaltung
plugin 'role_requirement', 
  :git => 'git://github.com/timcharper/role_requirement.git'
generate("roles" "Role User") 
end

if yes?("Git nutzen?")
  git :init

  file ".gitignore", <<-END
  .DS_Store
  log/*.log
  tmp/**/*
  config/database.yml
  db/*.sqlite3
  END

  run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
  run "cp config/database.yml config/example_database.yml"

  git :add => ".", :commit => "-m 'initial commit'"
end