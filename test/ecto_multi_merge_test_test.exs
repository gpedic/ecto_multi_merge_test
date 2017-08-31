defmodule TestTest do
  use ExUnit.Case
  doctest Test

  test "inserting a user" do
    user_params = %{first_name: "John", last_name: "Doe", email: "john@doe.com", password: "1234"}
    assert {:ok, _} = Test.invite_user(user_params)
  end
end
