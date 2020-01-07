class IceBreaker
    def greet

        def main
            puts "1. My IceBreakers"
            puts "2. Change my Username"
            puts "3. Change my Password"
            print "Please select from menu:"
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
            puts "IceBreaker will give you facts based on numbers that you can use to start a conversation with someone."
            print "Enter your new username:"
            new_username = gets.chomp
            binding.pry
            if new_username == User.find_by(name: new_username)
                puts "That user name already exists! Please try again:" 
                IceBreaker.yes       
            end               
            print "Enter your password:"
            new_user_password = gets.chomp
            #After password is entered, confirm password.
            print "Enter your birth_year:"
            birth_year = gets.chomp
            #Check to make sure that the year entered is valid
            #Get fact about year entered and then redirected to the mainmenu
            main
        end

        
        #***********************************************************************
                            #WELCOME TO ICEBREAKER!!


        puts "Welcome to IceBreaker!"
        puts "Is this your first time here?"
        print "Y or N:"
        y_n_question = gets.chomp.upcase 
        
        if y_n_question != "Y" && y_n_question != "N"
            puts "PLEASE ENTER Y OR N"
            self.greet
        elsif y_n_question ==  "Y"
            yes
        else
            main                  
        end
    end 
end
