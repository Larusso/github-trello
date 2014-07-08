require 'sinatra'
require 'json'
require 'client'
require 'comment_formatter'
require 'message_parser'
require 'pp'

class GithubTrello < Sinatra::Base
  puts 'GithubTrello'

  get '/' do
    "Hello World!"
  end

  post '/payload' do
    puts params
    puts 'execute payload'

    request.body.rewind
    request_payload = JSON.parse request.body.read

    if request_payload
      short_code = MessageParser.trello_short_code(push['head_commit']['message'])
      @card = Trello::Card.find(short_code) if short_code

      if short_code && @card
        author = push['head_commit']['author']['name']
        message = push['head_commit']['message']
        compare_url = push['compare']
        comment = CommentFormatter.new.formatted_comment(author, MessageParser.remove_trello_id(message), compare_url)
        @card.add_comment(comment)
      end
    end
  end
end

