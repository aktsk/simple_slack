# SimpleSlack

[![Build Status](https://travis-ci.org/aktsk/simple_slack.svg?branch=master)](https://travis-ci.org/aktsk/simple_slack)

Very simple slack client using incoming webhooks.


## Installation

Add `simple_slack` to `application` and `deps` in `mix.exs`.

Then, update your dependencies by `$ mix deps.get`.


## Usage

Get your token on slack webhook page.

```
$ iex -S mix
iex> token = "T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
iex> SimpleSlack.notify_text(token, "Ika is a sushi.")
```

### notify(token, payload)

Example:

```
SimpleSlack.notify(token, %{text: "Tako is a sushi too.",
                            username: "sushi-bot",
                            icon_emoji: ":sushi:"})
```

### notify_text(token, text, opts \\\\ %{})

Equivalent to `notify(token, Map.put(opts, :text, text))`.

### post(token, payload)

Equivalent to `notify(token, payload)` but blocks and returns `:ok` or `{:error, reason}`.


## For more details about Slack API

See [Basic message formatting](https://api.slack.com/docs/message-formatting) and [Attaching content and links to messages](https://api.slack.com/docs/message-attachments).
