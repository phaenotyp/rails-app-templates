run "echo TODO > README"

generate :nifty_layout

# GEMS
gem 'mislav-will_paginate', :version => '~> 2.2.3', 
  :lib => 'will_paginate',  :source => 'http://gems.github.com'
gem 'rubyist-aasm', :lib => "aasm", :source => 'http://gems.github.com'

rake("gems:install", :sudo => true)

# several Plugins  




if yes?('Restful Authenticate benutzen?')
  plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git'

  generate("authenticated", "user session --include-activation --aasm")

end

if yes?("ACL 2 nutzen?")
  plugin "acl_system2" ,
  :git => "git://github.com/ezmobius/acl_system2.git"
  generate(:nifty_scaffold, "role", "name:string")
  generate("roles_users","role_id:integer","user_id:integer")
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
rake ("db:migrate")