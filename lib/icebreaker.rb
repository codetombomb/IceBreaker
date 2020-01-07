class IceBreaker
    def greet
        
        puts "Welcome to IceBreaker!"
        puts "Is this your first time here?"
        print "Y or N:"
        y_n_question = gets.chomp.upcase
        
        
        if y_n_question != "Y" && y_n_question != "N"
            puts "PLEASE ENTER Y OR N"
            self.greet
        elsif y_n_question ==  "Y"
            puts "IceBreaker will generate a fact based on a random number you pick so that you can start a conversation with someone."
            print "Enter your new username:"
            new_username = gets.chomp
            #After username is input, check to see if username is uniq
            print "Enter your password:"
            new_user_password = gets.chomp
            #After password is entered, confirm password.
            print "Enter your favorite number:"
            favorite_number = gets.chomp
            
            #Add birth year column to user_table to return fact about year after completing signup.

        else
            puts "Welcome back!"
            #Upon return, uses favorite number to get random fact. Start with "Did you know #{favorite_number} is #{random_fact}?" 
            puts "1. My IceBreakers"
            puts "2. Change my Username"
            puts "3. Change my Password"
            puts "4. Change my Favorite Number"
            print "Please select from menu:"
            menu_selection = gets.chomp
            if menu_selection == 1 
                #Returns all of users facts with number, number type, and text.
            elsif menu_selection == 2
                #Utilize the User.name= method to change username
            elsif menu_selection == 3
                #Utilize the User.password= method to change username
            elsif menu_selection == 4
                #Utilize the User.favorite_number= method to change favorite number.
            end          
        end
    end 
end