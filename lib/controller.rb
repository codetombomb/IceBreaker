class IceBreaker
    attr_accessor :current_user
                          #WELCOME TO ICEBREAKER!!

             ###########   MAIN ICEBREAKER METHODS   ###########
    def intro   
        IceBreaker.banner_icebreaker                                          
        yes_or_no = PROMPT.yes?("\n\n\nAre you a new user?") do |q|
           q.suffix 'Y/N'
         end
       if yes_or_no 
        about 
       else
        IceBreaker.login        
       end
    end   

    def about
        puts "\n" * 35
        puts "\sIceBreaker WILL GIVE YOU FACTS\n\sBASED ON NUMBERS THAT YOU CAN USE\n TO START A CONVERSATION WITH SOMEONE NEW.".light_cyan
        puts "\n" * 5
        sign_up = PROMPT.select("SignUP or Exit", %w(SignUP Exit))
        case sign_up
        when "SignUP"
            @current_user = User.create_user 
            puts "\n" * 35           
            yes_or_no = PROMPT.yes?("We can find IceBreakers about a date in history.\n\s Would you like to try with your birthday?\n\n\n".light_cyan) do |q|            
                q.suffix 'Y/N'
            end
                if yes_or_no
                    puts "\n" * 35  
                    puts "❄" * 119       
                    fact = Fact.get_bday_fact(@current_user.birthday)
                    print "On #{Date::MONTHNAMES[@current_user.birthday.split(',')[1].to_i].light_cyan}"
                    print "\s#{@current_user.birthday.split(',')[2].to_i},\s".light_cyan
                    print "#{fact.year.light_cyan},\s\n"
                    puts "#{fact.text}"
                    puts "❄" * 119
                    puts "\n" * 5
                    save_fact = PROMPT.select("You can save this IceBreaker to your profile for quick reference by hitting the save button!
                    ", %W(Save Main))
                    case save_fact
                    when "Save"
                        save_fact = FactUser.new(user_id: @current_user.id, fact_id: fact.id )
                        save_fact.save
                        binding.pry
                        IceBreaker.main
                    else "Main"
                        IceBreaker.main
                    end
                else
                    IceBreaker.main
                end
    
            IceBreaker.main
        else "Exit"
            IceBreaker.quit
        end
    end 


    #set user_logged_in = true
    def self.login
        find_user = PROMPT.ask("What is your username?".light_cyan)
        @current_user = User.find_by(username: find_user)
        enter_password = PROMPT.mask('password:', echo: true)
        # binding.pry
        if enter_password == @current_user.password
            @current_user
            self.main
        else
            puts "\n" * 35
            puts "Access denied.".light_red
            puts "Please try again!".light_yellow
            self.login            
        end       
    end
    
    def self.main
        puts "\n" * 30
        IceBreaker.banner_icebreaker
        menu_selection = PROMPT.select("Select from the following options?", %w(MyIceBreakers Random_Icebreaker EditMyInfo LogOut Exit))
        case menu_selection
        when "MyIceBreakers"
            menu_selection = PROMPT.select('Select from the following options.', %w(ShowAll DeleteAll Main))
            case menu_selection
            when "ShowAll"
                puts "\n" * 30
                my_icebreakers = User.my_icebreakers(@current_user)
                menu_selection = PROMPT.select('Select from the following options.', %w(IceBreaker_Details Back))
                case menu_selection
                when "IceBreaker_Details"
                    binding.pry
                    #SHOW DETAILS OF ICEBREAKER
                else "Back"
                    IceBreaker.main
                end
            when "DeleteAll"
                binding.pry
                @current_user.facts.delete
                binding.pry
            else "Main"
                IceBreaker.main
            end

            #MyBirthday facts
            # Returns all of users facts with number, number type, and text.
            # Need ability to store facts Ive looked up
            #--- Given the option to delete all IceBreakers
        when "Random_Icebreaker"
             requested_type = PROMPT.select("Please select a category.", %w(Trivia Maths Date Year))
            case requested_type
            when "Trivia"
                trivia_fact = Fact.get_random_fact(requested_type.downcase)
                IceBreaker.display(trivia_fact)
                save_or_exit = PROMPT.select("Save or exit?", %w(Save Exit))
                case save_or_exit
                when "Save"
                    FactUser.save_icebreaker(@current_user.id,trivia_fact.id)
                # binding.pry
                else "Exit"
                    IceBreaker.main
                end
            when "Maths"
                Fact.get_math_fact
            when "Date"
                Fact.get_date_fact
            else "Year"
                Fact.get_year_fact
            # Given option to select type TRIVIA, MATH, DATE, YEAR
            end
        when "EditMyInfo"
            # Given the option to change my user information USERNAME, PASSWORD, AND BIRTHDAY
        when "LogOut"
            @current_user = nil
            IceBreaker.main
            # makes @user_logged_in = false            
        else "Exit"
            #Set logged in status to false
           self.quit
        end
    end

    def self.quit
        puts "\n" * 20
        print "\s" * 25,"HAVE A GREAT DAY!".light_yellow
        puts "\n"
        puts "                                                
             _____ _____ _____ ____  _____ __ __ _____ 
            |   __|     |     |     | __  |  |  |   __|
            |  |  |  |  |  |  |  |  | __ -|_   _|   __|
            |_____|_____|_____|____/|_____| |_| |_____|
                                        ".light_cyan.bold
        puts "\n" * 10             
    end 
    def self.banner_icebreaker
        puts "\n" * 30
        print "\s" * 42, "WELCOME TO".light_yellow.bold
        puts "\n" * 2
        puts " 
             _______                  ______                    __               
            |_     _|.----.-----.    |   __ |.----.-----.---.-.|  |--.-----.----.
             _|   |_ |  __|  -__|    |   __ <|   _|  -__|  _  ||    <|  -__|   _|
            |_______||____|_____|    |______/|__| |_____|___._||__|__|_____|__|  
                                                                           ".light_cyan.bold.blink
        puts "\n" * 10 
    end

    def self.display(facts)
        facts_to_a = [facts]
        # binding.pry
        facts_to_a.each do |fact|
            if fact.fact_type == "trivia" 
                puts "The number#{fact.number} refers to #{fact.text}"
            elsif fact.fact_type == "date"
                print "On #{Date::MONTHNAMES[@current_user.birthday.split(',')[1].to_i].light_cyan}"
                print "\s#{@current_user.birthday.split(',')[2].to_i},\s".light_cyan
                print "#{fact.year.light_cyan},\s\n"
                puts "#{fact.text}"
            end
            # binding.pry
        end
    end

end



    