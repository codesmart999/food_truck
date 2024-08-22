defmodule FoodTruckSearch do
  # Haversine formula to calculate distance between two lat/lng points in km
  defp calculate_distance(lat1, lng1, lat2, lng2) do
    to_rad = fn value -> value * :math.pi() / 180 end

    # Earth's radius in km
    r = 6371
    d_lat = to_rad.(lat2 - lat1)
    d_lng = to_rad.(lng2 - lng1)

    a =
      :math.sin(d_lat / 2) * :math.sin(d_lat / 2) +
        :math.cos(to_rad.(lat1)) * :math.cos(to_rad.(lat2)) *
          :math.sin(d_lng / 2) * :math.sin(d_lng / 2)

    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
    r * c
  end

  def find_nearest_locations(locations, selected_location, count) do
    selected_lat = String.to_float(selected_location["Latitude"])
    selected_lng = String.to_float(selected_location["Longitude"])

    distances =
      pre_process(locations)
      |> Enum.map(fn location ->
        lat = String.to_float(location["Latitude"])
        lng = String.to_float(location["Longitude"])

        distance = calculate_distance(selected_lat, selected_lng, lat, lng)
        %{location: location, distance: distance}
      end)

    distances
    |> Enum.filter(fn %{location: loc} -> loc["locationid"] != selected_location["locationid"] end)
    |> Enum.sort_by(& &1.distance)
    |> Enum.take(count)
    |> Enum.map(& &1.location)
  end

  def pre_process(data) do
    Enum.reject(data, fn location -> location["Latitude"] == "0" or location["Longitude"] == "0" end)
  end

  def nearest_count(""), do: 10
  def nearest_count(count) when is_binary(count), do: String.to_integer(count)

  def search(data, filters) do
    nearest_count = nearest_count(filters["nearest_place_count"])
    selected_location =
      Enum.find(data, fn location -> location["Address"] == filters["address"] end)

    locations =
    data
    |> find_nearest_locations(selected_location, nearest_count)

    {locations, selected_location}
  end
end
