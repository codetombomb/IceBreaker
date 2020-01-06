class User < ActiveRecord::Base
    has_many :users_facts
    has_many :facts, through: :users_facts
end