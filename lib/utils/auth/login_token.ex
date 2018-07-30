defmodule Utils.Auth.LoginToken do
  import Utils.Data.String
  import Utils.Redis

  def gen_token() do
    token = random_string(20)
    %{
      token: token,
    }
  end

  defp login_token_as_key(token) do
    "login-token-#{token}"
  end

  def cache_one_token(token, content) do
    token
    |> login_token_as_key
    |> set_and_get(content)
  end

  def get_info_from_cache(token) do
    token
    |> login_token_as_key
    |> get
  end

  def clear_all_login_tokens do
    get_keys("login-token-*")
    |> elem(1)
    |> del
  end
end
