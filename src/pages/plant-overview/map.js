function initializeMap() {
    var mymap = L.map('map').setView([46.8182, 8.2275], 8);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19
    }).addTo(mymap);

    return mymap;
}

function addMarkerToMap(map, lat, lng, name) {
    var marker = L.marker([lat, lng]).addTo(map);
    marker.bindPopup("<b>" + name + "</b><br>This is a plant.").openPopup();
}

document.addEventListener("DOMContentLoaded", function() {
    var mymap = initializeMap();

    var mapElements = document.getElementsByClassName("marker-data");

    for (var i = 0; i < mapElements.length; i++) {
        var lat = mapElements[i].getAttribute('data-lat');
        var lng = mapElements[i].getAttribute('data-lng');
        var name = mapElements[i].getAttribute('data-name');

        addMarkerToMap(mymap, lat, lng, name);
    }
});
