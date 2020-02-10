class User < ActiveRecord::Base
    has_many :fact_users
    has_many :facts, through: :fact_users

    #                                    #NEW USER SIGNUP
#                 ##################CREATE USER METHODS##################
 
# CREATE USER 
    def self.create_user
        new_user = self.get_username
        new_user.password = self.set_password
        puts "\n" * 35
        new_user.birthday = self.get_user_birthday
        new_user.save
        @current_user = new_user
    end  
    def self.get_user_birthday           
        birth_year = self.get_birth_year.to_i
        birth_month = self.get_birth_month.to_i
        puts "\n" * 35
        birth_day = self.get_birth_day.to_i
        User.verify_date(birth_year,birth_month,birth_day)
        user_birthday = "#{birth_year},#{birth_month},#{birth_day}"
    end
    def self.get_username
        given_username = PROMPT.ask("What do you want your new User Name to be?", required: true)
        confirm_username = PROMPT.yes?("#{given_username.light_green.bold} is what you entered. Are you sure?") do |q|
          q.suffix 'Y/N'
        end
        if confirm_username
           if User.find_by(username: given_username) == nil
                User.create(username: given_username)           
            else
                puts "#{given_username.light_red.bold} is already taken. Please choose a different username."
                 self.get_username 
            end
        else 
            self.get_username
        end
    end
# BIRTHDAY INFO
    def self.get_birth_year
        year_from_user = PROMPT.ask("What year were you born?".light_yellow, required: true) do |q| 
            q.validate(/(19|20)\d{2}/, 'The year must be four digits')
            q.in(1940..Date.today.year, 'The year must not be older than 1940')
        end
        year_from_user
    end
    def self.get_birth_month    
        puts "\n" * 35
        user_birth_month = PROMPT.ask('Please enter the month (MM) in which you were born'.light_cyan, required: true) do |q|
            q.in('01-12')
        end      
        user_birth_month
    end
    def self.get_birth_day
        user_birth_day = PROMPT.ask('Please enter the day (DD) of the you were born'.light_cyan) do |q|
            q.in('01-31')
        end
        user_birth_day
    end
    def self.verify_date(birth_year,birth_month,birth_day)                  
        birthday_valid = Date.valid_date?(birth_year,birth_month,birth_day)
        if birthday_valid
            birthday_valid
        else
            puts "Hmmm.. that's not right.".light_red
            puts "Let's try again."
            User.get_user_birthday
        end
    end
# SET PASSWORD
    def self.set_password
        given_password = PROMPT.mask("Please enter your password".light_yellow, required: true) do |q|
        q.validate(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
        q.messages[:valid?] = 'Your passowrd must be at least 6 characters and include one number and one letter'
      end        
        confirm_password = PROMPT.mask("Please confirm password".light_green, required: true)
        if given_password == confirm_password
            puts "\n" * 35
            given_password
        else
            puts "\n" * 35
            puts "Those didn't match. Please try again!".light_red
            self.set_password
        end
    end

    #NEED TO PARSE THE FACTS AND PRESENT THE FACT BASED ON THE TYPE OF FACT IT IS.
    def self.my_icebreakers(current_user)
        
        my_icebreakers = current_user.facts.each do |fact|
          puts "❄" * 95
          puts fact.text
          puts "❄" * 95
          puts "\n" * 5
        end
    end
        
        
end