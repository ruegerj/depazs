function initializeMap() {
    var mymap = L.map('map').setView([51.505, -0.09], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19
    }).addTo(mymap);

    var marker = L.marker([51.5, -0.09]).addTo(mymap);

    marker.bindPopup("<b>Hello World!</b><br>This is a Leaflet map.").openPopup();
}

document.addEventListener("DOMContentLoaded", function() {
    // Log the hmtl output
    console.log(document.documentElement.outerHTML);
    initializeMap();
});
