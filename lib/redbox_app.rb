
class RedBoxApp


  def run
    welcome
    sign_up_or_login
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

  def choose
      require "tty-prompt"
      prompt = TTY::Prompt.new
      
    sleep(1)
    puts "="*50
    list=%w(movies find_by_name rate_age rating)
    answer =  prompt.select(" Menu:", list)
    puts "="*50
    if answer == "movies"
      show_all_movie
    elsif
      answer == "find_by_name"
      movie_by_name
    elsif
      answer == "rate_age"
      movie_by_rate_age
    elsif
      answer == "rating"
      movie_by_rating
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
    
  def  rate_choice 
    require "tty-prompt"
    prompt = TTY::Prompt.new

    list=["G","R","PG-13"] #list = ["g","r","pg-13"]
    answer =  prompt.select(" Rating age:", list)
    puts "="*50
   

    Movie.all.select do |movie| 
      if movie.rate_age == answer
        puts movie.name
      end 
    end 
   
  end 

  def movie_by_rate_age
    rate_choice
  end 

  def movie_by_rating
    require "tty-prompt"
    prompt = TTY::Prompt.new

    list=[3,4,5] 
    answer = prompt.select(" Rating:", list)

    puts "="*50


    array = ActiveRecord::Base.connection.execute("
     SELECT
       movies.name, avg(rating) as average_rating
     FROM
       reviews
     JOIN
       movies
     ON reviews.movie_id = movies.id
     GROUP BY reviews.movie_id")


    array.each do |hash|
      if hash["average_rating"] > answer.to_i
         puts hash["name"]
      end
    end
  end 
 
  

end 