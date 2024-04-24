require 'dotenv/load'
require 'httparty'
require 'json'

api_key = ENV['WEATHER_API_KEY']
city = 'London'

# Need to convert city to lat/lon
response = HTTParty.get("http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}")
location_data = JSON.parse(response.body)
puts location_data
lat,lon = location_data[0]['lat'], location_data[0]['lon']

response = HTTParty.get("https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&appid=#{api_key}")
weather_data = JSON.parse(response.body)

puts weather_data
