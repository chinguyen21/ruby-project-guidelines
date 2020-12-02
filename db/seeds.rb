Movie.destroy_all
User.destroy_all
Review.destroy_all
Receipt.destroy_all

movie1 = Movie.create(name: "Breaking Bad", rate_age: "G", quantity: 10)
movie2 = Movie.create(name: "Game of Throne", rate_age: "R", quantity: 15)
movie3 = Movie.create(name: "Games", rate_age: "PG-13", quantity: 8)
movie4 = Movie.create(name: "Lion King", rate_age: "G", quantity: 0)


user1 = User.create(name: "Chi", email_address: "chi2101@gmail.com")
user2 = User.create(name: "Rahel", email_address: "rahel2020@gmail.com")

review1 = Review.create(content: "thrill movie 1", rating: 5, user_id: user1.id, movie_id: movie2.id)
review2 = Review.create(content: "sad", rating: 4, user_id: user2.id, movie_id: movie2.id)
review3 = Review.create(content: "cool", rating: 4, user_id: user1.id, movie_id: movie1.id)
review4 = Review.create(content: "thrill movie 2", rating: 3, user_id: user2.id, movie_id: movie1.id)

receipt1 = Receipt.create(user_id: user1.id, movie_id: movie2.id)
receipt2 = Receipt.create(user_id: user2.id, movie_id: movie3.id)
receipt3 = Receipt.create(user_id: user1.id, movie_id: movie1.id)
receipt4 = Receipt.create(user_id: user2.id, movie_id: movie4.id)




puts "dd"