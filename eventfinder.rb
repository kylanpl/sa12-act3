require 'dotenv/load'
require 'httparty'
require 'json'

@api_key = ENV['EVENT_API_KEY']

response = HTTParty.get("https://app.ticketmaster.com/discovery/v2/events?apikey=#{@api_key}&locale=*&city=Memphis")
event_data = JSON.parse(response.body)
events = event_data['_embedded']['events']
events.each do |event|
  puts "Name: #{event['name']}"
  venues = event['_embedded']['venues']
  puts "Venues:"
  venues.each do |venue|
    puts venue['name']
  end
  puts "Date: #{event['dates']['start']['localDate']}"
  puts "Time: #{event['dates']['start']['localTime']}"
  puts "URL: #{event['url']}"
  puts "-------------------"



end
