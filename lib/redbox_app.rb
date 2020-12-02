class RedBoxApp


  def run
    welcome
    sign_up_or_login
    display_action
    choose
  end 


  private

  def welcome
    puts "="*50
    puts "            Welcome to RedBox"
    puts "="*50
  end 

  def sign_up_or_login
    puts "Please enter your email address to sign up or login"
    email=gets.chomp.downcase

  
    if User.find_by(email_address: email).nil?
      puts "Please enter your name"
      user_name=gets.chomp.downcase
      @user = User.create(email_address: email,name: user_name)
      puts "Congratulations for creating an account!"
    else
      @user = User.find_by(email_address: email)
      puts "Happy to see you back!"
    end
  end 

  def display_action
    sleep(2)
    puts "="*50
    puts "Menu"
    puts "1.Shows all the movies"
    puts "2.Search movie by name"
    puts "3.Search movie by rate_age"
    puts "4.Search movie by rating"
    
    puts "="*50
    sleep(2)
  end 


  def choose
    puts "Type your choice"
    answer = gets.chomp.to_i
    if answer == 1
      show_all_movie
    elsif
      answer == 2
      movie_by_name
    elsif
      answer == 3
      movie_by_rate_age
    elsif
      answer == 4
      movie_by_rating
    else
      puts " Please select numbers from 1-4!"
    end 
  end

  def show_all_movie
      Movie.all.each do |t|
      puts t.name
    end 
  end 

  def movie_by_name
    puts "Enter movie name"
    movie_select=gets.chomp.downcase
    Movie.all.each do |t|
      if t.name.downcase == movie_select
      
       if t.quantity >=1
          print "It is available\n"
          
      else
        print  "Not available"

      end 
    end 
    end       
  end 

end 