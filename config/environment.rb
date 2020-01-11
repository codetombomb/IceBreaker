require 'bundler'
require 'unirest'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

#NEW INSTANCE OF TTY PROMPT FOR MENU FEATURE
PROMPT = TTY::Prompt.new

#REMOVE THE SQL FIRE FROM THE DIPLAYED INFO IN THE TERMINAL
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil