# The data contained in the jokes.json file comes from the Jokes API https://v2.jokeapi.dev/
# by running the following GET request: 
# https://v2.jokeapi.dev/joke/Programming?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&type=single&amount=10 
# This project is just using it to provide some examples

# Read from the JSON file and parse it into a hash
file = File.read("#{Rails.root.join('jokes.json')}")
data_hash = JSON.parse(file).deep_symbolize_keys

# Create Jokes into the database
data_hash[:jokes].each do |joke|
  Joke.create!(category: joke[:category], joke: joke[:joke])
end