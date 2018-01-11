# Add seed data here. Seed your database with `rake db:seed`

let(:artist_name) { "Person with a Face" }
let(:genre_1_name) { "Hippity Hop" }
let(:genre_2_name) { "New Age Garbage" }
let(:song_name) { "That One with the Guitar" }
let!(:genre_1) { Genre.create(name: genre_1_name) }
let!(:genre_2) { Genre.create(name: genre_2_name) }