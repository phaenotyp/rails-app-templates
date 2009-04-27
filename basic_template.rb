run "echo TODO > README"

generate :nifty_layout

# GEMS
gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
rake "gems:install"
# several Plugins  
plugin 'act_as_state_maschine', :git => 'git:github.com/rubyist/aasm.git'



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
