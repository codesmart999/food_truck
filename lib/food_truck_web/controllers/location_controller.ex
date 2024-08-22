defmodule FoodTruckWeb.LocationController do
  use FoodTruckWeb, :controller

  alias FoodTruck.CSV

  def index(conn, _params) do
    locations_record =
      CSV.list_facility_locations()

    render(conn, :index,
      changeset: %{},
      locations: locations_record,
      selected_location: "none",
      filtered_locations: "none",
      search: "none",
      summary: "none"
    )
  end

  def search(conn, params) do
    locations_record = CSV.list_facility_locations()
    {filtered_locations, selected_loc} = FoodTruckSearch.search(locations_record, params)
    summary = "#{params["nearest_place_count"]} places near #{params["address"]}"

    render(conn, :index,
      changeset: %{},
      selected_location: selected_loc,
      filtered_locations: filtered_locations,
      locations: locations_record,
      search: "show",
      summary: summary
    )
  end

  # def new(conn, _params) do
  #   changeset = Sales.change_location(%Location{})
  #   render(conn, :new, changeset: changeset)
  # end

  # def create(conn, %{"location" => location_params}) do
  #   case Sales.create_location(location_params) do
  #     {:ok, location} ->
  #       conn
  #       |> put_flash(:info, "Location created successfully.")
  #       |> redirect(to: ~p"/locations/#{location}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :new, changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   location = Sales.get_location!(id)
  #   render(conn, :show, location: location)
  # end

  # def edit(conn, %{"id" => id}) do
  #   location = Sales.get_location!(id)
  #   changeset = Sales.change_location(location)
  #   render(conn, :edit, location: location, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "location" => location_params}) do
  #   location = Sales.get_location!(id)

  #   case Sales.update_location(location, location_params) do
  #     {:ok, location} ->
  #       conn
  #       |> put_flash(:info, "Location updated successfully.")
  #       |> redirect(to: ~p"/locations/#{location}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :edit, location: location, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   location = Sales.get_location!(id)
  #   {:ok, _location} = Sales.delete_location(location)

  #   conn
  #   |> put_flash(:info, "Location deleted successfully.")
  #   |> redirect(to: ~p"/locations")
  # end
end
