# Git Receiver

Transforms data concerning git commits from a provided [`pre_push`](pre-push) script and places into a Firebase database.

## How to Use

1. `git init` from the command-line in your root directory;
2. Place the `pre_push` script inside `.git/hooks`, and delete the `pre_push.sample` file there;
3. Grab the `.env` from LastPass;
4. `rackup` to start the Git Receiver on `localhost:9292`, and
5. Commit as normal. A record of your commits will be pushed to Firebase on each `git push`.
