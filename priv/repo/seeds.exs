# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Logs.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
person  = Logs.Repo.insert!(%Logs.Person{id: 1, nick: "slash_nick", authorized: false})
channel2 = Logs.Repo.insert!(%Logs.Channel{id: 1, name: "ruby-offtopic", hidden: false})
message2 = Logs.Repo.insert!(%Logs.Message{person_id: person.id, channel_id: channel2.id, text: "DeBot: !hangman ruby", type: "message", hidden: false, created_at: Ecto.DateTime.utc})
channel = Logs.Repo.insert!(%Logs.Channel{id: 2, name: "RubyOnRails", hidden: false})
message = Logs.Repo.insert!(%Logs.Message{person_id: person.id, channel_id: channel.id, text: "Hello ROR", type: "message", hidden: false, created_at: Ecto.DateTime.utc})
