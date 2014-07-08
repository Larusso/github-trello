require 'trello'

Trello.configure do |config|
  puts ENV.fetch('TRELLO_KEY')
  config.developer_public_key = ENV.fetch('TRELLO_KEY')
  config.member_token = ENV.fetch('TRELLO_MEMBER_TOKEN')
end

