
require 'dotenv/load'
require 'httparty'
require 'json'

@api_key = ENV['EXCHANGE_API_KEY']


def convert(source, target, amount)
  response = HTTParty.get("https://v6.exchangerate-api.com/v6/#{@api_key}/pair/#{source}/#{target}/#{amount}")
  exchange_data = JSON.parse(response.body)
  return exchange_data['conversion_result']
end

puts convert('GBP', 'USD', 12345)
