const MapLocations = {
    mounted() {
        this.initMap()
        this.initSlide()
        this.locations = this.listLocations()

        if (this.el.dataset.showMarks === "show") {
            console.log(this.el.dataset);
            const selectedLocation = JSON.parse(this.el.dataset.selectedLocation);
            if (selectedLocation) {
                this.map.setCenter({ lat: parseFloat(selectedLocation["Latitude"]), lng: parseFloat(selectedLocation["Longitude"]) });
                this.map.setZoom(14);
                this.addMarkers(selectedLocation);
            }
        }
    },

    initMap() {
        this.markers = []

        this.map = new google.maps.Map(document.getElementById('map'), {
            center: { lat: 37.7749, lng: -122.4194 },
            zoom: 18
        });
    },

    calculateDistance(lat1, lng1, lat2, lng2) {
        const toRad = (value) => value * Math.PI / 180;
        const R = 6371; // Radius of the Earth in kilometers
        const dLat = toRad(lat2 - lat1);
        const dLng = toRad(lng2 - lng1);
        const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                  Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
                  Math.sin(dLng / 2) * Math.sin(dLng / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // Distance in kilometers
    },

    findNearestLocations(selectedLocation) {
        const distances = this.locations.map(location => {
            const distance = this.calculateDistance(
                parseFloat(selectedLocation["Latitude"]),
                parseFloat(selectedLocation["Longitude"]),
                parseFloat(location["Latitude"]),
                parseFloat(location["Longitude"]) 
            );
            return { location, distance };
        });

        return distances
            .filter(dist => dist.location !== selectedLocation)
            .sort((a, b) => a.distance - b.distance)
            .slice(0, 10)
            .map(dist => dist.location);
    },

    addMarkers(selectedLocation) {
        this.clearMarkers();

        const nearestLocations = this.findNearestLocations(selectedLocation);

        const selectedMarker = new google.maps.Marker({
            map: this.map,
            position: { lat: parseFloat(selectedLocation["Latitude"]), lng: parseFloat(selectedLocation["Longitude"]) },
            title: selectedLocation["Address"],
            icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
            locationId: selectedLocation["locationid"]
        });
        this.markers.push(selectedMarker);

        nearestLocations.forEach(location => {
            const marker = new google.maps.Marker({
                map: this.map,
                position: { lat: parseFloat(location["Latitude"]), lng: parseFloat(location["Longitude"])},
                title: location["Address"],
                locationId: location["locationid"]
            });
            this.markers.push(marker);

            const line = new google.maps.Polyline({
                path: [
                    { lat: parseFloat(selectedLocation["Latitude"]), lng: parseFloat(selectedLocation["Longitude"])},
                    { lat: parseFloat(location["Latitude"]), lng: parseFloat(location["Longitude"])  }
                ],
                geodesic: true,
                strokeColor: "#FF0000",
                strokeOpacity: 1.0,
                strokeWeight: 2
            });
            line.setMap(this.map);
        });
    },

    clearMarkers() {
        this.markers.forEach(marker => marker.setMap(null));
        this.markers = [];
    },

    blinkMarker(locationId) {
        const marker = this.findMarkerById(locationId);
        if (marker) {
          marker.setAnimation(google.maps.Animation.BOUNCE); // Make the marker bounce
        }
    },

    removeMarkerBlink(locationId) {
        const marker = this.findMarkerById(locationId);
        if (marker) {
          marker.setAnimation(null); // Stop marker bouncing
        }
      },

      findMarkerById(locationId) {
        // Assuming markers are stored in an array and each has a custom 'locationId' property
        return this.markers.find(marker => marker.locationId === locationId);
      },

    listLocations() {
        return JSON.parse(this.el.dataset.filteredLocations)
    },

    initSlide() {
        this.currentSlide = 0;
        this.slides = this.el.querySelectorAll('.slide');
        if (this.slides.length > 0) {
          this.showSlide(this.currentSlide);
          setInterval(() => this.nextSlide(), 5000); 

        }
    },
  
    showSlide(index) {
        this.slides.forEach((slide, i) => {
        slide.classList.remove('active');
        this.removeMarkerBlink(slide.dataset.locationId); // Stop blinking previous marker
        if (i === index) {
            slide.classList.add('active');
            this.blinkMarker(slide.dataset.locationId); // Blink the corresponding marker
        }
        });
    },
    
    nextSlide() {
        console.log("oh yeah")
        this.currentSlide = (this.currentSlide + 1) % this.slides.length;
        this.showSlide(this.currentSlide);
    }
}

export default MapLocations;