class User < ActiveRecord::Base
    has_many :fact_users
    has_many :facts, through: :fact_users

    #                                    #NEW USER SIGNUP
#                 ##################CREATE USER METHODS##################
#     #Date.valid_date?(year,month,day) 

    def self.create_user
        new_username = self.get_username
        user_password = self.set_password
        puts "\n" * 35
        yes_or_no = PROMPT.yes?("We can find IceBreakers about a date in history.\n\s Would you like to try with your birthday?\n\n\n".light_cyan) do |q|            
            q.suffix 'Y/N'           
        end
        if yes_or_no
            puts "\n" * 35           
            birth_year = self.get_birth_year.to_i
            birth_month = self.get_birth_month.to_i
            birth_day = self.get_birth_day.to_i
            verify_date = Date.valid_date?(birth_year,birth_month,birth_day) 
            # binding.pry       
            if verify_date
            user_birthday = "#{birth_year},#{birth_month},#{birth_day}"
            birthday_fact = Fact.get_date_fact(birth_month,birth_day)
#GRAB DATE AND RETURN A STRING WITH 'DID YOU KNOW THAT THIS HAPPENED ON YOUR BDAY?' 
            new_user = User.new
            new_user.username = new_username
            new_user.birthday = user_birthday
            new_user.save 
            # binding.pry
            puts "\n" * 35 
            puts "Alright! Now we can find IceBreakers!".light_yellow
            puts "\n" * 5 
            IceBreaker.main
            else
            puts "That is an invalid date.".light_yellow
            puts "Please try again!".light_red
            self.get_birth_year
            end
        else
            puts "\n" * 35
            print "It's COOL".light_cyan
            print " #{new_username}".light_yellow
            puts ", you can add your birthday later if you want!".light_cyan
            new_user = User.new
            new_user.username = new_username
#STILL NEED TO PERSIST NEW USER
            puts "\n" * 5
            IceBreaker.main 
        end    
    end    

    def self.get_username
        given_username = PROMPT.ask("What do you want your new User Name to be?", required: true)
        yes_or_no = PROMPT.yes?("#{given_username.light_green.bold} is what you entered. Are you sure?") do |q|
          q.suffix 'Y/N'
        end
        if yes_or_no 
            given_username
        else
            self.get_username
        end
    end




    def self.get_birth_year
        year_from_user = PROMPT.mask("What year were you born? We'll keep it a secret".light_yellow).to_i
        if year_from_user < 1940
            puts "Either that was an invalid entry or you are old as dirt!".light_cyan
            print " Please try again.".light_red
            self.get_birth_year
        end
        # binding.pry
        if year_from_user < Date.today.year && year_from_user.to_s.length == 4
        year_from_user
        else
        puts "\n" * 35
        puts "That is an invalid entry.".light_red
        print "Please try again."
        self.get_birth_year           
        end
    end


    def self.get_birth_month
        puts "\n" * 35
        user_birth_month = PROMPT.ask('Please enter the month (MM) in which you were born'.light_cyan) do |q|
            q.in('00-12')
        end
        user_birth_month
    end
    def self.get_birth_day
        puts "\n" * 35
        puts "Sweet, just one more thing".light_yellow
        user_birthday = PROMPT.ask('Please enter the day (DD) of the you were born'.light_cyan) do |q|
            q.in('00-31')
        end
        user_birthday
    end

    def self.set_password
        puts "\n" * 35
        given_password = PROMPT.mask("Please enter a password up to 20 characters".light_yellow, required: true)
        confirm_password = PROMPT.mask("Please confirm password".light_green, required: true)
        if given_password == confirm_password
            given_password
        else
            puts "Those didn't match. Please try again!".light_red
            self.set_password
        end
    end
        
        
end