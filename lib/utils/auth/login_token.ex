defmodule Utils.Auth.LoginToken do
  import Pbkdf2.Base

  def gen_token(salt) do
    current = DateTime.utc_now()
    base = to_string(current)

    hash_password(base, salt)
  end
end
