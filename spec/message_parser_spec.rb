require 'spec_helper'

describe MessageParser do
  let(:short_code) { MessageParser.trello_short_code(message) }

  context 'with a known good message' do
    let(:message) do
      "Merge branch 'master' into develop\n\n* master:\n  Don't try to submit invoices unless they're ready\n  Process invoices in the background\n\nhttps://trello.com/c/0jTMFm2d"
    end

    it 'parses the shortcode from the trello url if present' do
      expect(short_code).to eq('0jTMFm2d')
    end

    it 'removes the shortcode line from the message'
  end

  context 'with a known bad message' do
    let(:message) { "Merge branch 'master' into develop" }

    it 'parses the shortcode from the trello url if present' do
      expect(short_code).to be_nil
    end
  end
end

describe MessageParser do
  let(:out) {MessageParser.remove_trello_short_code(input)}

  context 'with a trello message' do
    let(:input) do
      "[trello-0jTMFm2d]Merge branch 'master' into develop\n\n* master:\n  Don't try to submit invoices unless they're ready\n  Process invoices in the background\n\nhttps://trello.com/c/0jTMFm2d"
    end

    it 'removes the shortcode url if present' do
      expect(out).to eq("[trello-0jTMFm2d]Merge branch 'master' into develop\n\n* master:\n  Don't try to submit invoices unless they're ready\n  Process invoices in the background\n\n")
    end
  end
end
