let mymap;

function initializeMap() {
    mymap = L.map('map').setView([46.8182, 8.2275], 8);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19
    }).addTo(mymap);
    console.log("Map initialized");
}

function addMarkerToMap(lat, lng, name) {
    console.log("Adding marker to map");
    var marker = L.marker([lat, lng]).addTo(mymap);
    marker.bindPopup("<b>" + name + "</b><br>This is a plant.").openPopup();
}

document.addEventListener("DOMContentLoaded", function() {
    initializeMap();
});
