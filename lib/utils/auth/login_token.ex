defmodule Utils.Auth.LoginToken do
  import Utils.Data.String

  def gen_token() do
    token = random_string(20)
    %{
      token: token,
    }

  end
end
