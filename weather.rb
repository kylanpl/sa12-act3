require 'dotenv/load'
require 'httparty'
require 'json'

api_key = ENV['WEATHER_API_KEY']
city = 'Washington D.C.'

# Need to convert city to lat/lon
response = HTTParty.get("http://api.openweathermap.org/geo/1.0/direct?q=#{city}}&appid=#{api_key}")
location_data = JSON.parse(response.body)
lat,lon = location_data[0]['lat'], location_data[0]['lon']

response = HTTParty.get("https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&appid=#{api_key}")
weather_data = JSON.parse(response.body)

temperatures = weather_data['hourly'].map { |hour| hour['temp'] }
average_temperature = temperatures.sum / temperatures.size
# seems like its in kelvin so i convert to f
average_temperature = (average_temperature - 273.15) * 9/5 + 32
# needs to be rounded now
average_temperature = average_temperature.round(0)

puts "Average Temperature: #{average_temperature}°F"
