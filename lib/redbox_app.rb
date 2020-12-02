class RedBoxApp


  def run
    welcome
    sign_up_or_login
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

    puts"Please enter your name"
    user_name=gets.chomp.downcase

    if User.find_by(email_address: email).nil?
      @user = User.create(email_address: email,name: user_name)
      puts "Congratulations to sign up Redbox"

    elsif
      i=0
      while User.find_by(email_address: email).name != user_name && i < 3 do
        puts "Please enter the correct name"
        user_name = gets.chomp.downcase
        i+=1
      end


      @user = User.find_by(email_address: email)
      puts "Happy to see you back"
    end
  end 
end 