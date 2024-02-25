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

document.addEventListener("DOMContentLoaded", function () {
    var mymap = initializeMap();

    var mapElements = Array.from(document.getElementsByClassName("marker-data"));

    mapElements.forEach(function (element) {
        var lat = element.getAttribute('data-lat');
        var lng = element.getAttribute('data-lng');
        var name = element.getAttribute('data-name');

        addMarkerToMap(mymap, lat, lng, name);
    });
});
