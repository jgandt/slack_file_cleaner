require 'pry_debug'
require 'httparty'
require 'slack'

SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']

file_res = HTTParty.get("https://slack.com/api/files.list?count=300ts_to=1495660186&token=#{ SLACK_API_TOKEN }")

files = file_res['files']

files.reject do |file|
  file['created'] < 30.days.ago.to_i
end.each do |file|
  raise "STOP DO NOT DELETE"
  HTTParty.get("https://slack.com/api/files.delete?file=#{file['id']}&token=#{ SLACK_API_TOKEN }")
end

