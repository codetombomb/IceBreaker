class FactUser < ActiveRecord::Base
    belongs_to :user
    belongs_to :fact
    
    def self.save_icebreaker(user_id,fact_id)
        save_fact = FactUser.new(user_id: user_id, fact_id: fact_id)
        save_fact.save
        # binding.pry
    end
end