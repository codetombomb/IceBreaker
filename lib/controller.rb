class IceBreaker
  PROMPT = TTY::Prompt.new

             #WELCOME TO ICEBREAKER!!
    def intro
        puts "\n" * 30
        print "\s" * 42, "Welcome to".light_yellow.bold
        puts "\n" * 2
        puts " 
             _______                  ______                    __               
            |_     _|.----.-----.    |   __ |.----.-----.---.-.|  |--.-----.----.
             _|   |_ |  __|  -__|    |   __ <|   _|  -__|  _  ||    <|  -__|   _|
            |_______||____|_____|    |______/|__| |_____|___._||__|__|_____|__|  
                                                                           ".               light_cyan.   bold
        puts "\n" * 10                                              
        y_n_question = PROMPT.yes?("\n\n\nAre you new to Icebreaker?") do |q|
           q.suffix 'Y/N'
         end
       if y_n_question 
           about
       elsif
           y_n_question == false
           main           
       end
    end

    

    def about
        puts "\n" * 30
        puts "\sIceBreaker will give you facts\n\sbased on numbers that you can use to\n start a conversation with someone.".light_cyan
        puts "\n" * 2
        sign_up = PROMPT.select("SignUP or Exit", %w(SignUP Exit))
        case sign_up
        when "SignUP"
            create_user
        when "Exit"
            exit
        end
    end    
    
    
    
    
    
    
    def create_user
      puts 'Create a new User Name'
      username = gets.chomp
      
    end













    
    
    
    
    
    
    
    
    
    
    
    
    def main
        # prompt = TTY::Prompt.new

        menu_selection = prompt.select("Select from the following options?", %w(MyIceBreakers Change--MyUsername Change--MyPassword Exit))
        
        # binding.pry
        case menu_selection
        when "MyIceBreakers"
            # Returns all of users facts with number, number type, and text.
            # Need ability to store facts Ive looked up
        when "Change--MyUsername"
        #     Utilize the User.name= method to change username
        when "Change--MyPassword"
        #     Utilize the User.password= method to change username
        when "Exit"
           exit
        end
    end


    def exit
        puts "\n" * 20
        print "\s" * 21,"Now go meet someone new!".light_yellow
        puts "\n"
        puts "                                                
             _____ _____ _____ ____  _____ __ __ _____ 
            |   __|     |     |     | __  |  |  |   __|
            |  |  |  |  |  |  |  |  | __ -|_   _|   __|
            |_____|_____|_____|____/|_____| |_| |_____|
                                        ".light_cyan.bold
        puts "\n" * 10             
    end


end