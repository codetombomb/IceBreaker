class fact < ActiveRecord::Base
    has_many :users, through :users_facts
end