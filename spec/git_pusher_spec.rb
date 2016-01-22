require 'git_pusher'

describe GitPusher do
  subject(:git_pusher) { described_class.new }

  describe '#push_to_receiver' do
    it 'sends commit and user data to Git Receiver' do
      expect(git_pusher).to respond_to :push_to_receiver
    end
  end
end