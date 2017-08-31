defmodule Repo do
  use Ecto.Repo,
      otp_app: :ecto_multi_merge_test
end

defmodule User do
  use Ecto.Schema

  schema "user" do
    field :first_name
    field :last_name
    field :email
    field :password
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, ~w(first_name last_name email password))
    |> Ecto.Changeset.validate_required([])
  end
end

defmodule Test do
  alias Ecto.Multi

  def invite_user(params) do
    multi = Multi.new
      |> Multi.merge(__MODULE__, :create_user_multi, [params])
      |> Multi.merge(__MODULE__, :send_email_multi, [params])

    Repo.transaction(multi)
  end

  def create_user_multi(multi, user_params) do
    multi
    |> Multi.insert(:user, User.changeset(%User{}, user_params))
  end

  def send_email_multi(multi, user_params) do
    multi
    |> Multi.run(:invite, fn %{user: user} ->
      IO.inspect(user)
    end)
  end

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Test.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

#Ecto.Multi.new |> Ecto.Multi.insert(:user, %Test.User{}) |> Test.Repo.transaction