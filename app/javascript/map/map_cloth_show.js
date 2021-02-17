let markers = [];
if (document.URL.match(/\/cloth_stores\/\d+/) || document.URL.match(/\/reviews\/create/)) {
  window.initMap = function () {
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 15,
      center: { lat: gon.cloth_store.latitude, lng: gon.cloth_store.longitude },
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
      position: { lat: gon.cloth_store.latitude, lng: gon.cloth_store.longitude },
      draggable: true,
    });
    geocoder.geocode({ latLng: { lat: gon.cloth_store.latitude, lng: gon.cloth_store.longitude } }, (results) => {
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
}