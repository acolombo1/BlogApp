# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_user = User.create(name: 'Tom', photo: 'https://acolombo1.github.io/Portfolio/foto1.jpg', bio: 'Teacher from Mexico.', email: 'tomsmail@yahoo.com', role: 'admin', posts_counter: 0)
second_user = User.create(name: 'Lilly', bio: 'Teacher from Poland.', email: 'lilly@yahoo.com', posts_counter: 0)
first_user.password = '123456'
first_user.password_confirmation = '123456'
first_user.confirm
second_user.password = '123456'
second_user.password_confirmation = '123456'
second_user.confirm

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
Post.create(author: first_user, title: 'Post nr 2', text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it 1960s with the releaLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it 1960s with the releax map lapora verita.', likes_counter: 0, comments_counter: 0)
Post.create(author: first_user, title: 'Post nr 3', text: 'This is my 3rd post', likes_counter: 0, comments_counter: 0)
Post.create(author: first_user, title: 'Post nr 4', text: 'This is my 4th post', likes_counter: 0, comments_counter: 0)

Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
Comment.create(post: first_post, author: first_user, text: 'Hi, how are you?')
Comment.create(post: first_post, author: second_user, text: 'Fine, thanks, and you?')
Comment.create(post: first_post, author: first_user, text: 'I\'m ok, how are you going with your posts?')
Comment.create(post: first_post, author: second_user, text: 'I still have none')
Comment.create(post: first_post, author: first_user, text: 'I have four already')
