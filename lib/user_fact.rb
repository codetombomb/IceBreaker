class UserFact < ActiveRecord::Base
    belongs_to :users
    belongs_to :facts
end