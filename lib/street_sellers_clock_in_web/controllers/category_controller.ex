defmodule StreetSellersClockInWeb.CategoryController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.Product
  alias StreetSellersClockIn.Product.Category

  action_fallback(StreetSellersClockInWeb.FallbackController)

  def index(conn, _params) do
    product_categories = Product.list_product_categories()
    render(conn, "index.json", product_categories: product_categories)
  end

  def create(conn, %{"category" => category_params}) do
    with {:ok, %Category{} = category} <- Product.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Product.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Product.get_category!(id)

    with {:ok, %Category{} = category} <- Product.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Product.get_category!(id)

    with {:ok, %Category{}} <- Product.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
