# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

#config :ecto_multi_merge_test, Repo,
#       adapter: Ecto.Adapters.Postgres,
#       database: "ecto_multi_merge_test",
#       username: System.get_env("USER"),
#       password: "",
#       hostname: "localhost",
#       port: "5432"

config :ecto_multi_merge_test, Repo,
       adapter: Sqlite.Ecto2,
       database: "test.sqlite3"

config :ecto_multi_merge_test, ecto_repos: [Repo]