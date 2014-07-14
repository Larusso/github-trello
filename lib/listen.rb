require 'sinatra'
require 'json'
require 'client'
require 'comment_formatter'
require 'message_parser'
require 'pp'

class GithubTrello < Sinatra::Base
  
  post '/payload' do
    pp params
    request_payload = JSON.parse(params[:payload])
    pp request_payload    
    unless request_payload.nil?
      message = request_payload['head_commit']['message']      
      short_code = MessageParser.trello_short_code(message)
      trello_card = Trello::Card.find(short_code) if short_code

      unless short_code.nil? and trello_card.nil?
        author = request_payload['head_commit']['author']['name']
        compare_url = request_payload['compare']
        clean_message = MessageParser.remove_trello_short_code(message)
        comment = CommentFormatter.new.formatted_comment(author, clean_message, compare_url)
        puts trello_card
        trello_card.add_comment(comment)
      end
    end
  end
end

