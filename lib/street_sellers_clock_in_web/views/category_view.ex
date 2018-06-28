defmodule StreetSellersClockInWeb.CategoryView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.CategoryView

  def render("index.json", %{product_categories: product_categories}) do
    %{data: render_many(product_categories, CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      name: category.name,
      memo: category.memo
    }
  end
end
