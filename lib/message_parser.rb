class MessageParser
  def self.trello_short_code(commit_message)
    result = commit_message.match(%r|https://trello.com/c/(.*)|)
    result[1] if result
  end

  def self.remove_trello_short_code(commit_message)
  	result = commit_message.gsub(%r|https://trello.com/c/(.*)|,'')
  	return result
  end
end

