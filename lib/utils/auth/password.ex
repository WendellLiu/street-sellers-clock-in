defmodule Utils.Auth.Password do
  import Comeonin.Pbkdf2, warn: false

  def hash_password(password) do
    hashpwsalt(password)
  end

  def check_password(password, hash) do
    checkpw(password, hash)
  end
end
