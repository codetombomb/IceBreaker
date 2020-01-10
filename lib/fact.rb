class Fact < ActiveRecord::Base
    has_many :fact_users
    has_many :users, through: :fact_users    

    def self.get_date_facts       
       
    end
end