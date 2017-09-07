defmodule InflatorWeb.PageController do
  use InflatorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
