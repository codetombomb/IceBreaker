class FactUser < ActiveRecord::Base
    belongs_to :user
    belongs_to :fact
end