class Fact < ActiveRecord::Base
    has_many :fact_users
    has_many :users, through: :fact_users    

    def self.get_date_facts       
        #  response = Unirest.post https://numbersapi.p.rapidapi.com/{month}/{day}/date,
        #  headers:{
        #   "X-RapidAPI-Key" => 03ad68a3d9msh715db69b24278b8p1c06acjsncb379bcf54f4
        #  },
        #  parameters:{
        #  "content" => File.new("/path/to/file", "rb")
        #  }
        #  binding.pry
    end
end