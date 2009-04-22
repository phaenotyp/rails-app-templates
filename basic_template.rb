run "echo TODO > README"

generate :nifty_layout


gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
gem 'acts_as_state_machine', :lib => 'acts_as_state_machine',  :source => 'http://gems.github.com'
rake "gems:install"


plugin 'acl_system2', :git => 'git://github.com/ezmobius/acl_system2.git'
generate :acl_system2


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
