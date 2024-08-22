# Food Truck Finder 🍔🚚

🚨 **Before You Start:** Watch [this video](https://www.loom.com/share/efeb0a2b3f8142be84c27028e2c27ced?sid=4689bedc-0f34-4dd7-838c-2f5282475e89) to see the whole process in action! 🎥

Welcome to the **Food Truck Finder** app, where we make sure no one in your company goes hungry! Built with the Phoenix framework and Elixir, this app is your go-to solution for finding the nearest food trucks when the lines are too long, or the food runs out at your current spot. Let’s make sure everyone gets their favorite snack without the hassle! 🌮🌭🍕🍟

## Storytime: The Great Food Truck 🍽️

Imagine this: Your entire team went out for a lunch break to your favorite food truck. The sun is shining, everyone’s excited, but oh no! 😱 There aren’t enough places to sit, and the food supply is running low. What do you do?

Fear not! The **Food Truck Finder** is here to save the day. Simply select your current location and the number of nearby food trucks you want to explore. Our app will search for the closest options, showing you the results on a Google Map with a slick slideshow and blinking markers. Problem solved—everyone’s happy and fed! 🎉

## Features 🛠️

- **Location Selection**: Choose your current food truck location.
- **Nearest Food Truck Search**: Specify how many nearby food trucks you want to find.
- **Google Maps Integration**: See the results on an interactive Google Map.
- **Dynamic Slideshow**: Watch as the food trucks are showcased one by one, complete with blinking markers on the map.
- **Production-Ready with Docker**: Deploy with ease using our Docker setup.

## How It Works 🔍

1. **Select Your Location**: Use the dropdown to choose your current food truck location.
2. **Pick the Number of Nearby Places**: Decide how many food trucks you want to check out.
3. **Search and Explore**: Our app will show you the nearest food trucks on a Google Map. Watch the slideshow for detailed info and keep an eye on those blinking markers!

## To Run Locally 🖥️

### Prerequisites

- Elixir and Phoenix installed on your machine.
- Docker (if you want to use the Docker setup).

### Running the App

1. **Clone the repository**:

    ```bash
    git clone https://codesmart999@github.com/codesmart999/food_truck.git
    
    cd food_truck
    ```

2. **Install dependencies**:

    ```bash
    mix deps.get
    ```

3. **Set up the environment**:

    ```bash
    mix ecto.setup
    ```

4. **Start the Phoenix server**:

    ```bash
    mix phx.server
    ```

5. **Visit the app**:

    Open your browser and go to [`localhost:4000`](http://localhost:4000).

## To Run Using Docker 🐳

We’ve made it super easy to get this app running in production with Docker.

1. **Build the Docker image**:

    ```bash
    docker build -t food_truck .
    ```

2. **Run the Docker container**:

    ```bash
    docker run -p 4000:4000 food_truck
    ```

3. **Visit the app**:

    Open your browser and go to [`localhost:4000`](http://localhost:4000).

## Technologies Used 🛠️

- **Elixir**: The language that powers our app.
- **Phoenix Framework**: The web framework for building scalable and maintainable web applications.
- **Google Maps API**: For displaying the nearest food trucks on a map.
- **Docker**: For easy deployment and scalability.

## Contributing 🤝

We welcome contributions! If you find any bugs or have suggestions for new features, feel free to open an issue or submit a pull request.


## Acknowledgments 🙏

A huge thank you to our team for their hunger-driven motivation to build this app. May all your food truck adventures be delicious and satisfying!

---

**Bon appétit!** 🎉
