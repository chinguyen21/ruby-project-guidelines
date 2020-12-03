require "date"
require 'active_support/all'
require "pry"
class RedBoxApp 
  def run
    welcome
    sign_up_or_login
    list_of_choices  
  end
  
  private

  def prompt
    TTY::Prompt.new
  end

  def welcome
    puts "=" * 50
    puts "            Welcome to RedBox"
    puts "=" * 50
  end 

  def sign_up_or_login
    email = prompt.ask("Please enter your email address to sign up or login:").downcase
    user = User.find_by(email_address: email)
    if user.nil?
      user_name = prompt.ask("Please enter your name:").downcase
      @user = User.create(email_address: email, name: user_name)
      puts "Congratulations for creating an account!"
    else
      @user = user
      puts "Happy to see you back!"
    end
  end 

  def list_of_choices
    sleep(1)
    puts "=" * 50
    list = %w(All_movies Movies_by_name Movies_by_rate_age Movies_by_rating Checked_out_history Return)
    answer = prompt.select("SEARCH:", list, symbols: { marker: ">>" })
    puts "=" * 50
    if answer == "All_movies"
      show_all_movies
    elsif answer == "Movies_by_name"
      movies_by_name
    elsif answer == "Movies_by_rate_age"
      movies_by_rate_age
    elsif answer == "Movies_by_rating"
      movies_by_rating
    elsif answer == "Checked_out_history"
      checked_out_history 
    elsif answer == "Return"
      return_movie
    end
  end

  def return_movie
    return_movie_list = []
    @user.receipts.map do |receipt|
      if receipt.status == "open rental"

        movie = Movie.find_by(id: receipt.movie_id)
        return_movie_list << "#{movie.name} =>   Return Date: #{receipt.return_date}"
      end
    end
    select_movie = prompt.select("Which movie do you want to return?", return_movie_list)
    Movie.all.each do |movie|
      if movie.name == select_movie
        update_quantity = Movie.find_by(id: movie_id).quantity + 1
        Movie.update(movie_id, quantity: update_quantity)
        puts Receipt.find_by(movie_id: movie_id)
        #Receipt.find()
        #1. Games => Return Date: 12/03/2020
        #2. Games => Return Date: 12/05/2020
      end
    end
    
    
  end



  def checked_out_history
    @user.receipts.each do |receipt|
        movie = Movie.find_by(id: receipt.movie_id)
        puts "#{movie.name} =>   Return Date: #{receipt.return_date}"
      # @user.movies.map {|movie| movie.name}
    end
  end

  def show_all_movies
      movies = Movie.all.map {|t| t.name}
      prompt_list_movies(movies) 
  end 


  def movies_by_name
    movie_typing = prompt.ask("Enter movie name:").downcase
    movies = Movie.where('lower(name) = ?', movie_typing).first.name
    prompt_list_movies(movies) 
  end

  def movies_by_rate_age
    list = ["G","R","PG-13"] 
    answer = prompt.select("RATING AGE:", list)
    puts "=" * 50
    movies = Movie.where(rate_age: answer).map {|t| t.name}
    prompt_list_movies(movies)
  end 

  def movies_by_rating
    answer = prompt.select("Select Rating Range:", ["1-2","2-3","3-4","4-5"], symbols: { marker: ">>" })
    puts "=" * 50 
    movies = Movie.all.map do |movie|
      if movie.rating >= answer[0].to_i && movie.rating < answer[-1].to_i
        movie.name
      end
    end
    prompt_list_movies(movies)
  end

  def check_out(movie_id, user_id)
    ask = prompt.yes?("Do you want to rent this movie?")
    if ask == true
      new_receipt = Receipt.create(movie_id: movie_id, user_id: user_id, checkout_date: Time.now, return_date: Time.now + 7.days.to_i, status: "open rental") 
      update_quantity = Movie.find_by(id: movie_id).quantity - 1
      Movie.update(movie_id, quantity: update_quantity) 
      puts "Successful check out #{Movie.find_by(id: movie_id).name}. Your rent is due on #{new_receipt.return_date}."
    else
      list_of_choices
    end
  end

  def prompt_list_movies(movies)
    select_movie = prompt.select("Movie:", movies, symbols: { marker: ">>" })
    Movie.all.each do |movie|
        if movie.name == select_movie
          puts "Information | Rating_age: #{movie.rate_age} | Rating: #{movie.rating} | Available: #{movie.available?}"
          if movie.available? == "yes"
            check_out(movie.id, @user.id)
          else
            choice = prompt.select("#{movie.name} is not available.", ["Back to the menu", "Sign out"])
            choice == "Back to the menu" ? list_of_choices : sign_out
          end
        end
    end
  end

  def sign_out
    puts "See you next time!"
  end


end 

