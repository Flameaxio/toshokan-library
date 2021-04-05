# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create!([{ name: 'Fantasy' }, { name: 'Classical' }, { name: 'Sci-Fi' }, { name: 'Adventure' }, \
              { name: 'Comic' }, { name: 'Detective' }, { name: 'Historical' }, \
              { name: 'Horror' }, { name: 'Romance' }])
Author.create!([{ name: 'William Shakespeare' },
                { name: 'Agatha Christie' },
                { name: 'Barbara Cartland' },
                { name: 'Danielle Steel' },
                { name: 'Harold Robbins' },
                { name: 'Georges Simenon' },
                { name: 'Enid Blyton' },
                { name: 'Sidney Sheldon' },
                { name: 'J. K. Rowling' }])

# Authors
shakespear = Author.where(name: 'William Shakespeare').first
christie = Author.where(name: 'Agatha Christie').first
steel = Author.where(name: 'Danielle Steel').first
dobbins = Author.where(name: 'Harold Robbins').first
simenon = Author.where(name: 'Georges Simenon').first
blyton = Author.where(name: 'Enid Blyton').first
sheldon = Author.where(name: 'Sidney Sheldon').first
rowling = Author.where(name: 'J. K. Rowling').first

# Genres
fantasy = Genre.where(name: 'Fantasy').first
classical = Genre.where(name: 'Classical').first
scifi = Genre.where(name: 'Sci-Fi').first
adventure = Genre.where(name: 'Adventure').first
comic = Genre.where(name: 'Comic').first
detective = Genre.where(name: 'Detective').first
historical = Genre.where(name: 'Historical').first
horror = Genre.where(name: 'Horror').first
romance = Genre.where(name: 'Romance').first

# Books creation
Book.create!([{ name: 'Hamlet', authors: [shakespear], genres: [classical], image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B07VMPFCKM/resources/1574674465' },
              { name: 'Harry Potter', authors: [rowling], genres: [adventure, fantasy], image_url: 'https://images-na.ssl-images-amazon.com/images/I/91l1Op79AWL.jpg' },
              { name: 'The Murder of Roger Ackroyd', authors: [christie], genres: [detective], image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B01NARUK3U/images/cover.jpg' },
              { name: 'Royal', authors: [steel], genres: [historical], image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B081Y4MM12/resources/314890188' },
              { name: 'The Carpetbaggers', authors: [dobbins], genres: [romance], image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B00AJGNIL8/images/cover.jpg' },
              { name: 'Maigret and the Calame report', authors: [simenon], genres: [scifi], image_url: 'https://images-na.ssl-images-amazon.com/images/I/51A9FRH5F0L.jpg' },
              { name: 'Stories of Pixies and Elves', authors: [blyton], genres: [comic], image_url: 'https://images-na.ssl-images-amazon.com/images/I/716LcDg2dKL.jpg' },
              { name: 'The Sands of Time', authors: [sheldon], genres: [horror], image_url: 'https://d188rgcu4zozwl.cloudfront.net/content/B003P2WOGS/images/cover.jpg' }])
