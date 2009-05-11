run "echo TODO > README"

generate :nifty_layout

# GEMS
gem 'mislav-will_paginate', :version => '~> 2.2.3', 
  :lib => 'will_paginate',  :source => 'http://gems.github.com'
gem 'rubyist-aasm'
gem 'ruby-openid'
 

rake("gems:install", :sudo => true)

# several Plugins  




if yes?('Restful Authenticate benutzen?')
  plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git'

  generate("authenticated", "user session --include-activation --aasm")

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
