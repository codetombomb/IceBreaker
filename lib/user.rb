class User < ActiveRecord::Base
    has_many :fact_users
    has_many :facts, through: :fact_users
end