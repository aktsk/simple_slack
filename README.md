# SimpleSlack

[![Build Status](https://travis-ci.org/aktsk/simple_slack.svg?branch=master)](https://travis-ci.org/aktsk/simple_slack)
[![Hex.pm](https://img.shields.io/hexpm/v/simple_slack.svg?maxAge=2592000)](https://hex.pm/packages/simple_slack)
[![Hex.pm](https://img.shields.io/hexpm/l/simple_slack.svg?maxAge=2592000)](https://github.com/aktsk/simple_slack/blob/master/LICENSE)

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

Other examples:

```
SimpleSlack.notify(token, %{text: "Maguro is a sushi too.",
                            username: "sushi-bot",
                            icon_emoji: ":sushi:"})

SimpleSlack.notify(token, %{text: "Tako is a sushi too.",
                            attachments: [%{author_name: "sushi-taisho",
                                            fallback: "Required plain-text summary of the attachment.",
                                            title: "sushi-attachment",
                                            text: "Optional text"}]})
```


## For more details about Slack API

See [Basic message formatting](https://api.slack.com/docs/message-formatting) and [Attaching content and links to messages](https://api.slack.com/docs/message-attachments).
