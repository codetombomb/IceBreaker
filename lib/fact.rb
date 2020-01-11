class Fact < ActiveRecord::Base
    has_many :fact_users
    has_many :users, through: :fact_users

    def self.get_date_fact(birth_month,birth_day)
        response = Unirest.get "https://numbersapi.p.rapidapi.com/#{birth_month}/#{birth_day}/date?fragment=true&json=true",
        headers:{
        "X-RapidAPI-Host" => "numbersapi.p.rapidapi.com",
        "X-RapidAPI-Key" => "03ad68a3d9msh715db69b24278b8p1c06acjsncb379bcf54f4"
        }
        new_fact = Fact.find_or_create_by(number: response.body["number"]) do |fact|
            fact.text = response.body["text"]
            fact.fact_type = response.body["type"]
            fact.number = response.body["number"]
            fact.year = response.body["year"]
        end
        if new_fact == nil
            self.get_date_fact
        end
        binding.pry
    end
end