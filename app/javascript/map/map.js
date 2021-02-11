let markers = [];
window.initMap = function () {
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 5,
    center: { lat: 35.6804, lng: 139.766 },
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
  map.addListener("dblclick", (event) => {
    deleteMarker();
    geocoderAddressDblclick(geocoder, map, event.latLng);
  });
  document.getElementById("map-search-submit").addEventListener("click", () => {
    deleteMarker();
    geocoderAddressSearch(geocoder, map);
  });
}
function geocoderAddressSearch(geocoder, resultMap) {
  const address = document.getElementById("map-search").value;
  geocoder.geocode({ address: address }, (results, status) => {
    if (status === "OK") {
      resultMap.setCenter(results[0].geometry.location);
      resultMap.setZoom(15);
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
function addMarker(location) {
  const marker = new google.maps.Marker({
    map: map,
    position: location,
    draggable: true,
  });
  markers.push(marker);
}
function deleteMarker() {
  if (markers[0]) {
    markers[0].setMap(null);
    markers = [];
  }
}