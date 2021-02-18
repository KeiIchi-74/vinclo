let markers = [];
document.addEventListener("turbolinks:load", () => {
  if (document.URL.match(/\/cloth_stores\/\d+/) || document.URL.match(/\/reviews\/create/)) {
    removeGoogleMapScript();
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.GOOGLE_MAP_API_KEY}&callback=initMap&libraries=&v=weekly`;
    script.async = true;
    window.initMap = function () {
      const map = new google.maps.Map(document.getElementById("map"), {
        zoom: 15,
        center: { lat: gon.latitude, lng: gon.longitude },
        streetViewControl: true,
        streetViewControlOptions: {
          position: google.maps.ControlPosition.RIGHT_CENTER,
        },
        zoomControl: true,
        zoomControlOptions: {
          position: google.maps.ControlPosition.RIGHT_CENTER,
        },
        mapTypeControl: false,
        gestureHandling: "cooperative",
        disableDoubleClickZoom: true,
      });
      const geocoder = new google.maps.Geocoder();
      const marker = new google.maps.Marker({
        map: map,
        position: { lat: gon.latitude, lng: gon.longitude },
        draggable: true,
      });
      geocoder.geocode({ latLng: { lat: gon.latitude, lng: gon.longitude } }, (results) => {
        const infowindow = new google.maps.InfoWindow({
          content: results[0].formatted_address,
        }); 
        infowindow.open(map, marker);
        marker.addListener("click", () => {
          infowindow.open(map, marker);
        });
      });
      markers.push(marker);
      map.addListener("dblclick", (event) => {
        deleteMarker();
        geocoderAddressDblclick(geocoder, map, event.latLng);
      });
    }
    document.head.appendChild(script);
    function geocoderAddressDblclick(geocoder, resultMap, latLng) {
      geocoder.geocode({ latLng: latLng }, (results, status) => {
        if (status === "OK") {
          const marker = new google.maps.Marker({
            map: resultMap,
            position: results[0].geometry.location,
            draggable: true,
          });
          const infowindow = new google.maps.InfoWindow({
            content: results[0].formatted_address,
          }); 
          marker.addListener("click", () => {
            infowindow.open(resultMap, marker);
          });
          markers.push(marker);
        } else {
          alert("検索候補は見つかりませんでした:" + status);
        }
      });
    }
    function deleteMarker() {
      if (markers[0]) {
        markers[0].setMap(null);
        markers = [];
      }
    } 
    function removeGoogleMapScript() {
      const keywords = ['maps.googleapis.com'];
      window.google = undefined;
      const scripts = document.head.getElementsByTagName("script");
      for (let i = scripts.length - 1; i >= 0; i--) {
        const scriptSource = scripts[i].getAttribute('src');
        if (scriptSource != null) {
          if (keywords.filter((keyword) => scriptSource.includes(keyword)).length) {
            scripts[i].remove();
          }
        }
      }
    }
  }
});