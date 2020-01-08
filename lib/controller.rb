class IceBreaker
    
    def main
        puts "1. My IceBreakers"
        puts "2. Change my Username"
        puts "3. Change my Password"
        puts "Please select from menu:"
        menu_selection = gets.chomp
        if menu_selection == 1 
            #Returns all of users facts with number, number type, and text.
        elsif menu_selection == 2
            #Utilize the User.name= method to change username
        elsif menu_selection == 3
            #Utilize the User.password= method to change username
        end
    end

    def yes
        prompt = TTY::Prompt.new
        puts "\nIceBreaker will give you facts based on numbers\nthat you can use to start a conversation with someone.\n\n".light_magenta
        sign_up = prompt.multi_select("SignUP or Exit".light_yellow, %w(SignUP Exit))
        if sign_up == ["SignUP"]
            puts "Enter New Username".light_yellow
            new_username = gets.chomp
            binding.pry
        else
            #needs to quit app and not go to main
            greet
        end
    end



        # binding.pry
    #     if User.find_by(username: new_username)
    #         puts "That user name already exists! Please try again:" 
    #         yes
    #     else 
    #         new_user = User.new
    #         new_user.username = new_username
    #         new_user.save                      
    #     end               
    #     puts "Enter your password:"
    #     new_user_password = gets.chomp
    #     #After password is entered, confirm password.
    #     puts "Enter your birth_year:"
    #     birth_year = gets.chomp
    #     #Check to make sure that the year entered is valid
    #     #Get fact about year entered and then redirected to the mainmenu
    #     main
    # end

    
    #***********************************************************************
                        #WELCOME TO ICEBREAKER!!

def greet
    prompt = TTY::Prompt.new
    puts "Welcome to".light_blue
    puts " 
         _______                  ______                    __               
        |_     _|.----.-----.    |   __ |.----.-----.---.-.|  |--.-----.----.
         _|   |_ |  __|  -__|    |   __ <|   _|  -__|  _  ||    <|  -__|   _|
        |_______||____|_____|    |______/|__| |_____|___._||__|__|_____|__|  
                                                                        ".light_blue.bold
    
 
    puts 'Are you new to IceBreaker?'.light_yellow
    y_n_question = prompt.multi_select("Yes or No?", %w(Yes No Exit))

    # binding.pry
    if y_n_question == ["Yes"]
        yes
    elsif
        y_n_question == ["No"]
        main
    else
        y_n_question == ["Exit"]   
         greet               
    end
end 
end
