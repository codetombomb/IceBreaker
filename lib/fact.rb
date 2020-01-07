class Fact < ActiveRecord::Base
    has_many :fact_users
    has_many :users, through: :fact_users    
end