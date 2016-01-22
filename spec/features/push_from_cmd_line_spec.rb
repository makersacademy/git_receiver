require 'git_pusher'

describe 'Pushing to receiver from the command line' do
  let(:service) { GitPusher.new }

  before do
    system("cd spec/fixtures")
    system("mkdir test")
    system("cd test")
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
    system("cd spec/fixtures")
    system("rm -rf test")
  end

  private

  def makersinit
    system("cd spec/fixtures")
    system("makersinit")
  end

  def make_commit
    system("cd spec/fixtures")
    system("touch test_file_#{rand(0..58400)}.rb")
    system("git add .")
    system("git commit -m 'test commit'")
  end

  def push_commit
    system("cd spec/fixtures")
    system("git push origin master")
  end

  def commits_data
    "{\"email\": \"s_morgan@me.com\", \"commits\": [\"49f23ce3e34cb4b0b52b07ca27b85de753adb347\"], \"remote_url\": \"https://github.com/sjmog/rps-challenge.git\"}"
  end
end