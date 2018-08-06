defmodule StreetSellersClockIn.StartupTask do
import Logger, only: [info: 1]
import Utils.Auth.LoginToken
import StreetSellersClockIn.Accounts.Helpers

  def warm do
    # warming the caches
    info "warming the cache"

    # Token Cacheing
    info "warming the token cache"
    clear_all_login_tokens()
    cache_active_token()

    info "finished warming the cache, shutting down"
  end
end
