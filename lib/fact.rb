class Fact < ActiveRecord::Base
    has_many :fact_users
    has_many :users, through: :fact_users

    def self.get_bday_fact(user_birthday)
        # binding.pry
        month = user_birthday.split(',')[1]
        day= user_birthday.split(',')[2]
        response = Unirest.get "https://numbersapi.p.rapidapi.com/#{month}/#{day}/date?fragment=true&json=true",
        headers:{
        "X-RapidAPI-Host" => "numbersapi.p.rapidapi.com",
        "X-RapidAPI-Key" => "03ad68a3d9msh715db69b24278b8p1c06acjsncb379bcf54f4"
        }
        fact = Fact.find_or_create_by(text: response.body["text"]) do |fact|
            fact.text = response.body["text"]
            fact.fact_type = response.body["type"]
            fact.number = response.body["number"]
            fact.month_day = user_birthday.last(3)
            fact.year = response.body["year"]
            end
        fact
    end


    def self.get_random_fact(fact_type)
        # binding.pry
        response = Unirest.get "https://numbersapi.p.rapidapi.com/random/#{fact_type}?max=20&fragment=true&min=10&json=true",
        headers:{
          "X-RapidAPI-Host" => "numbersapi.p.rapidapi.com",
          "X-RapidAPI-Key" => "03ad68a3d9msh715db69b24278b8p1c06acjsncb379bcf54f4"
        }
        random_fact = Fact.find_or_create_by(text: response.body["text"])do |fact|
            fact.text = response.body["text"]
            fact.fact_type = response.body["type"]
            fact.number = response.body["number"]
            fact.year = response.body["year"]
            end
            # binding.pry
        random_fact 
    end
    def self.get_math_fact
    end
    def self.get_date_fact
    end
    def self.get_year_fact
    end
end