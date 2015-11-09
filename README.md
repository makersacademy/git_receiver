# Git Receiver

Transforms data concerning git commits from a provided [`pre_push`](pre-push) script and places into a Firebase database.

## How to Use

1. Copy the contents of [`bash_script`](bash_script) to the bottom of your `/Users/<your username>/.bash_profile`;
2. `makersinit` from the command-line in your root directory, and
3. commit as normal. A record of your commits will be pushed to Firebase on each `git push`.

## Under the hood

Writing the contents of [`bash_script`](bash_script) to your `.bash_profile` enables the `makersinit` command from the command line.

Running `makersinit` will:

1. Initialize a git repository with `git init`;
2. Overwrite the `.git/hooks/pre-push.sample` script with a script that pushes commit details to `localhost:9292` on every `git push` you do in this repo;
3. Rename the `.git/hooks/pre-push.sample` script to `.git/hooks/pre-push`.

## Playing in Development

Grab a `.env` for the test server from LastPass. Then, running `rackup` will:

1. Start a server on `localhost:9292` that takes POST requests from `pre-push` scripts initialized with `makersinit`;
2. Extract relevant parts from the POST payload (user, commit details, URLs), and push them to a Firebase.
