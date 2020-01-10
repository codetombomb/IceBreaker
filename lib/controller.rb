class IceBreaker
    attr_accessor :user_logged_in
    attr_reader :user_info

                          #WELCOME TO ICEBREAKER!!

             ###########   MAIN ICEBREAKER METHODS   ###########
    def intro   
        IceBreaker.banner_icebreaker                                          
        yes_or_no = PROMPT.yes?("\n\n\nAre you new to Icebreaker?") do |q|
           q.suffix 'Y/N'
         end
       if yes_or_no 
           about
       elsif
            IceBreaker.login          
       end
    end   

    def about
        puts "\n" * 30
        puts "\sIceBreaker WILL GIVE YOU FACTS\n\sBASED ON NUMBERS THAT YOU CAN USE\n TO START A CONVERSATION WITH SOMEONE NEW.".light_cyan
        puts "\n" * 5
        sign_up = PROMPT.select("SignUP or Exit", %w(SignUP Exit))
        case sign_up
        when "SignUP"
            User.create_user
            IceBreaker.main
        else "Exit"
            IceBreaker.quit
        end
    end 


    #set user_logged_in = true
    def self.login
        puts "\n" * 35
        find_user = PROMPT.ask("What is your username?".light_cyan)
        @user_logged_in = User.find_by(username: find_user)
        binding.pry        
        self.main
    end
    
    def self.main
        puts "\n" * 30
        IceBreaker.banner_icebreaker
        menu_selection = PROMPT.select("Select from the following options?", %w(MyIceBreakers Find_By_Year Random_Trivia Change_MyUsername Change_Password LogOut Exit))
        case menu_selection
        when "MyIceBreakers"
            # Returns all of users facts with number, number type, and text.
            # Need ability to store facts Ive looked up
            # Given the option to delete a specific Icebreaker
            # Given the option to delete all IceBreakers
        when "Find_By_Year"
            # Parse the Random Fact Numbers API for fact
            # Displays number and fact
            # Given the option to save to MyIceBreakers
        when "Random_Trivia"
            # Given option to select type TRIVIA, MATH, DATE, YEAR
        when "Change_Username"
            #@user_logged_in must be true
        when "Change_Password"
            #@user_logged_in must be true
        when "LogOut"
            # makes @user_logged_in = false            
        else "Exit"
            #@user_logged_in must be true
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
                                                                           ".               light_cyan.   bold
        puts "\n" * 10 
    end

end



    