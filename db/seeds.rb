# Add seed data here. Seed your database with `rake db:seed`

set(:artist_name) { "Person with a Face" }
set(:genre_1_name) { "Hippity Hop" }
set(:genre_2_name) { "New Age Garbage" }
set(:song_name) { "That One with the Guitar" }
set(:genre_1) { Genre.create(name: genre_1_name) }
set(:genre_2) { Genre.create(name: genre_2_name) }
@song = Song.create(name: song_name)
