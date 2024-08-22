defmodule LocationUtils do
  # Function to calculate the distance between two points given their latitude and longitude
  def calculate_distance(lat1, lng1, lat2, lng2) do
    to_rad = fn value -> value * :math.pi / 180 end
    r = 6371 # Radius of the Earth in kilometers

    d_lat = to_rad.(lat2 - lat1)
    d_lng = to_rad.(lng2 - lng1)

    a = :math.sin(d_lat / 2) * :math.sin(d_lat / 2) +
        :math.cos(to_rad.(lat1)) * :math.cos(to_rad.(lat2)) *
        :math.sin(d_lng / 2) * :math.sin(d_lng / 2)

    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
    r * c # Distance in kilometers
  end

  # Function to find the nearest locations
  def find_nearest_locations(selected_location, locations) do
    selected_lat = String.to_float(selected_location["Latitude"])
    selected_lng = String.to_float(selected_location["Longitude"])

    distances =
      Enum.map(locations, fn location ->
        lat = String.to_float(location["Latitude"])
        lng = String.to_float(location["Longitude"])

        distance = calculate_distance(selected_lat, selected_lng, lat, lng)
        %{location: location, distance: distance}
      end)

    distances
    |> Enum.filter(fn %{location: location} -> location != selected_location end)
    |> Enum.sort_by(& &1.distance)
    |> Enum.take(10)
    |> Enum.map(& &1.location)
  end
end
