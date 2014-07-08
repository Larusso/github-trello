require 'sinatra'
require 'json'
require 'client'
require 'comment_formatter'
require 'message_parser'

class GithubTrello < Sinatra::Base
  puts 'GithubTrello'

  get '/' do
    "Hello World!"
  end

  post '/payload' do
    puts 'execute payload'
    if params[:Payload]
      push = JSON.parse(params[:Payload])
      puts push
      short_code = MessageParser.trello_short_code(push['head_commit']['message'])
      @card = Trello::Card.find(short_code) if short_code

      puts short_code
      puts @card

      if short_code && @card
        author = push['head_commit']['author']['name']
        message = push['head_commit']['message']
        compare_url = push['compare']
        comment = CommentFormatter.new.formatted_comment(author, message, compare_url)
        @card.add_comment(comment)
      end
    end
  end
end

