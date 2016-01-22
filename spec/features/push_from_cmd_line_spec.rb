require 'git_pusher'

describe 'Pushing to receiver from the command line' do
  
  # Ensure you have `makersinit` available as a command first
  context 'with `makersinit` available as a command' do
    let(:service) { GitPusher.new }

    before do
      system("mkdir ../git_pusher_test")
      allow(Kernel).to receive(:`).with("git config user.email").and_return "s_morgan@me.com"
    end

    it 'sends data to the receiving webhook' do
      # Expect the final push command with the lovely data
      expect(service).to receive(:push_to_receiver).with(commits_data)
      makersinit
      make_commit
      push_commit
    end

    after do
      system("rm -rf ../git_pusher_test")
    end
  end

  private

  def makersinit
    system("cd ../git_pusher_test && makersinit")
  end

  def make_commit
    system("cd ../git_pusher_test && touch test_file_#{rand(0..58400)}.rb && git add . && git commit -m 'test commit'")
  end

  def push_commit
    system("cd ../git_pusher_test && git push origin master")
  end

  def commits_data
    "{\"email\": \"s_morgan@me.com\", \"commits\": [\"49f23ce3e34cb4b0b52b07ca27b85de753adb347\"], \"remote_url\": \"https://github.com/sjmog/rps-challenge.git\"}"
  end
end