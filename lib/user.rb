class User < ActiveRecord::Base
    has_many :facts, through :users_facts
end