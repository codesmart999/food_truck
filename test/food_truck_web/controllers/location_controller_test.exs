defmodule FoodTruckWeb.LocationControllerTest do
  use FoodTruckWeb.ConnCase

  import FoodTruck.SalesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all locations", %{conn: conn} do
      conn = get(conn, ~p"/locations")
      assert html_response(conn, 200) =~ "Listing Locations"
    end
  end

  describe "new location" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/locations/new")
      assert html_response(conn, 200) =~ "New Location"
    end
  end

  describe "create location" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/locations", location: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/locations/#{id}"

      conn = get(conn, ~p"/locations/#{id}")
      assert html_response(conn, 200) =~ "Location #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/locations", location: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Location"
    end
  end

  describe "edit location" do
    setup [:create_location]

    test "renders form for editing chosen location", %{conn: conn, location: location} do
      conn = get(conn, ~p"/locations/#{location}/edit")
      assert html_response(conn, 200) =~ "Edit Location"
    end
  end

  describe "update location" do
    setup [:create_location]

    test "redirects when data is valid", %{conn: conn, location: location} do
      conn = put(conn, ~p"/locations/#{location}", location: @update_attrs)
      assert redirected_to(conn) == ~p"/locations/#{location}"

      conn = get(conn, ~p"/locations/#{location}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, location: location} do
      conn = put(conn, ~p"/locations/#{location}", location: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Location"
    end
  end

  describe "delete location" do
    setup [:create_location]

    test "deletes chosen location", %{conn: conn, location: location} do
      conn = delete(conn, ~p"/locations/#{location}")
      assert redirected_to(conn) == ~p"/locations"

      assert_error_sent 404, fn ->
        get(conn, ~p"/locations/#{location}")
      end
    end
  end

  defp create_location(_) do
    location = location_fixture()
    %{location: location}
  end
end
