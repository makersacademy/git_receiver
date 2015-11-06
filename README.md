# Git Receiver

Transforms data concerning git commits from a provided [`pre_push`][pre-push] script and places into a Firebase database.

## How to Use

1. `git init` from the command-line in your root directory;
2. Place the `pre_push` script inside `.git/hooks`;
3. `rackup` to start the Git Receiver on `localhost:9292`;
4. Commit as normal. A record of your commits will be pushed to Firebase on each `git push`.