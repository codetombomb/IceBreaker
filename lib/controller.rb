class IceBreaker
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
        puts "\n" * 35
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
            @@current_user = User.create_user 
            puts "\n" * 35           
            yes_or_no = PROMPT.yes?("We can find IceBreakers about a date in history.\n\s Would you like to try with your birthday?\n\n\n".light_cyan) do |q|            
                q.suffix 'Y/N'
            end
                if yes_or_no
                    puts "\n" * 35
                    user_month = @@current_user.birthday.split(',')[1]
                    user_day = @@current_user.birthday.split(',')[2]
                    fact = [Fact.get_date_fact(user_month, user_day)]
                    IceBreaker.display(fact)
                    save_fact = PROMPT.select("You can save this IceBreaker to your profile for quick reference by hitting the save button!
                    ", %W(Save Main))
                    case save_fact
                    when "Save"                        
                        FactUser.save_icebreaker(@@current_user.id,fact[0].id)
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

    def self.login
        login_or_exit = PROMPT.select("", %w(Login Exit))
        case login_or_exit
        when "Login"
            puts "\n" * 35
            find_user = PROMPT.ask("What is your username?".light_cyan, required: true)
            @@current_user = User.find_by(username: find_user)
            if @@current_user == nil
                puts "User not found".light_red
                puts "Please try again!"
                self.login
            end
            enter_password = PROMPT.mask('password:', echo: true,required: true)
            if enter_password == @@current_user.password
                @@current_user
                self.main
            else
                puts "\n" * 35
                puts "Access denied.".light_red
                puts "Please try again!".light_yellow
                self.login 
            end
        else "Exit"
            IceBreaker.quit  
                 
        end       
    end
    
    def self.main
        puts "\n" * 30
        if @@current_user == nil
            puts "You have to be logged in to use IceBreaker :("
            IceBreaker.login
        else
        IceBreaker.banner_icebreaker
        puts "Hello #{@@current_user.username.light_yellow.bold}!"
        puts "\n" 
        menu_selection = PROMPT.select("Select from the following options?", %w(MyIceBreakers RandomIcebreaker DateIcebreaker YearIcebreaker EditMyInfo LogOut))
        case menu_selection
        when "MyIceBreakers"
            menu_selection = PROMPT.select('Select from the following options.', %w(ShowAll DeleteAll Main))
            case menu_selection
            when "ShowAll"
                puts "\n" * 35
                IceBreaker.display(@@current_user.facts)
                menu_selection = PROMPT.select('Select from the following options.', %w( Back))
                case menu_selection
                when "Back"
                    IceBreaker.main
                end
            when "DeleteAll"
                are_you_sure = PROMPT.yes?('Are you sure you want to delete all?') do |q|
                q.suffix 'Y/N'
                    end
                if are_you_sure
                @@current_user.facts.delete_all
                IceBreaker.main
                else
                  IceBreaker.main
                end
            else "Main"
                IceBreaker.main
            end
        when "RandomIcebreaker"
             requested_type = PROMPT.select("Please select a category.", %w(Trivia Math Back))
            case requested_type
            when "Trivia"
                puts "\n" * 35
                trivia_fact = [Fact.get_random_fact(requested_type.downcase)]
                # self.banner_fascinating
                IceBreaker.display(trivia_fact)
                save_or_exit = PROMPT.select("Save or exit?", %w(Save Exit))
                case save_or_exit
                when "Save"
                    save_fact = FactUser.save_icebreaker(@@current_user.id,trivia_fact[0].id)
                    @@current_user.facts << trivia_fact
                    IceBreaker.main
                else "Exit"
                    IceBreaker.main
                end
            when "Math"
                puts "\n" * 35
                trivia_fact = [Fact.get_random_fact(requested_type.downcase)]
                # self.banner_wow
                IceBreaker.display(trivia_fact)
                save_or_exit = PROMPT.select("Save or exit?", %w(Save Exit))
                case save_or_exit
                when "Save"
                    save_fact = FactUser.save_icebreaker(@@current_user.id,trivia_fact[0].id)
                    @@current_user.facts << trivia_fact
                    IceBreaker.main
                else "Exit"
                    IceBreaker.main
                end
            else "Back"
                IceBreaker.main            
            end
        when "DateIcebreaker"
            month = PROMPT.ask("Please enter a month (MM) of interest.".light_cyan, required: true) do |q|
                q.in('01-12')
            end
            day = PROMPT.ask('Please enter the day (DD) of interest'.light_cyan, required: true) do |q|
                q.in('01-31')
            end
            puts "\n" * 35
            # self.banner_didyouknow
            trivia_fact = [Fact.get_date_fact(month,day)]
            IceBreaker.display(trivia_fact)
            save_or_exit = PROMPT.select("Save or exit?", %w(Save Exit))
            case save_or_exit
            when "Save"
              save_fact = FactUser.save_icebreaker(@@current_user.id,trivia_fact[0].id)
              @@current_user.facts << trivia_fact
              IceBreaker.main
            else "Exit"
              IceBreaker.main
            end        
        when "YearIcebreaker"
            year = PROMPT.ask('Please enter the year (YYYY) of interest'.light_cyan, required: true) do |q|
                q.in(1..Date.today.year)
            end
            puts "\n" * 35
            trivia_fact = [Fact.get_year_fact(year)]
            IceBreaker.display(trivia_fact)
            save_or_exit = PROMPT.select("Save or exit?", %w(Save Exit))
            case save_or_exit
            when "Save"
              save_fact = FactUser.save_icebreaker(@@current_user.id,trivia_fact[0].id)
              @@current_user.facts << trivia_fact
              IceBreaker.main
            else "Exit"
              IceBreaker.main
            end        
        when "EditMyInfo"
            self.edit_my_info
        else "LogOut"
            @@current_user = nil
            IceBreaker.main
            end
        end
    end

    def self.quit
        puts "\n" * 20
        print "\s" * 25,"HAVE A GREAT DAY!".light_yellow
        puts "\n"
        puts "                                                
         ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗
        ██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
        ██║  ███╗██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ █████╗  
        ██║   ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██╔══╝  
        ╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ███████╗
         ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝
                                        ".light_cyan.bold
        puts "\n" * 10             
    end 

    def self.banner_icebreaker
        puts "\n" * 30
        print "\s" * 50, "WELCOME TO".light_yellow.bold
        puts "\n" * 2
        puts " 
               ██╗ ██████╗███████╗    ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗███████╗██████╗ 
               ██║██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝██╔════╝██╔══██╗
               ██║██║     █████╗      ██████╔╝██████╔╝█████╗  ███████║█████╔╝ █████╗  ██████╔╝
               ██║██║     ██╔══╝      ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗ ██╔══╝  ██╔══██╗
               ██║╚██████╗███████╗    ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗███████╗██║  ██║
               ╚═╝ ╚═════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  
                                                                           ".light_cyan.bold.blink
        puts "\n" * 5 
    end

    def self.display(facts)
        facts.uniq.each do |fact|
            if fact.fact_type == "trivia" 
                puts "\n"
                puts "❄" * 113
                print "The number".light_cyan
                puts "\s#{fact.number}".light_cyan
                puts "refers to #{fact.text}"
                puts "❄" * 113
                puts "\n" 
            elsif fact.fact_type == "date"
                puts "\n"
                puts "❄" * 113
                print "On #{Date::MONTHNAMES[fact.month_day.split(',')[0].to_i]}".light_cyan
                print "\s#{fact.month_day.split(',')[1].to_i},\s".light_cyan
                print "#{fact.year.light_cyan},\s\n"
                puts "#{fact.text}"
                puts "❄" * 113
                puts "\n"
            elsif fact.fact_type == "math"
                puts "\n"
                puts "❄" * 113
                print "In Math, the number".light_cyan
                puts "\s#{fact.number}".light_cyan
                puts "is #{fact.text}"
                puts "❄" * 113
                puts "\n" 
            elsif fact.fact_type == "year"
                puts "\n"
                puts "❄" * 113
                print "In the year #{fact.number}".light_cyan
                puts ",\s#{fact.text}"
                puts "❄" * 113
                puts "\n" 
            end
        end
    end
    
    def self.edit_my_info
        puts "\n" * 35
        pick_an_edit = PROMPT.select("Change Username or Password?", %w(Username Password Back))
        case pick_an_edit
           when "Username"
                self.change_username
                IceBreaker.main
           when "Password"
                self.change_password
                puts "Your password was successfully changed"
                IceBreaker.main 
           else "Back"
            IceBreaker.main             
            end
    end

    def self.change_username
        given_username = PROMPT.ask("Alright #{@@current_user.username.light_green}, what do you want your new User Name to be?", required: true)
        confirm_username = PROMPT.yes?("#{given_username.light_green.bold} is what you entered. Are you sure?") do |q|
                q.suffix 'Y/N'
            end
        if confirm_username
            if User.find_by(username: given_username) == nil 
                @@current_user.username = nil   
                @@current_user.username = given_username
                @@current_user.save
            else
                puts "#{given_username.light_red.bold} is already taken. Please choose a different username."
                self.change_username
            end
        else 
            self.edit_my_info
        end
    end

    def self.change_password
        old_password = PROMPT.mask("Please enter your old password".light_yellow, required: true)
        if old_password == @@current_user.password
            new_password = PROMPT.mask("Please enter your new password".light_cyan, required: true) do |q|
            q.validate(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
            q.messages[:valid?] = 'Your passowrd must be at least 6 characters and include one number and one letter'
          end        
            confirm_password = PROMPT.mask("Please confirm your new password".light_green, required: true)
            if new_password == confirm_password
                puts "\n" * 35
                @@current_user.password = nil
                @@current_user.password = new_password
            else
                puts "\n" * 35
                puts "Those didn't match. Please try again!".light_red
                self.change_password
            end
        else
            puts "That was not right.".light_red
            puts "Please try again"
            self.change_password
        end
    end
end



    