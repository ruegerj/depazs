function initializeMap() {
    var mymap = L.map('map').setView([46.8182, 8.2275], 8);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19
    }).addTo(mymap);

    return mymap;
}

function addMarkerToMap(map, lat, lng, name, prices) {
    var popupContent = "<div class='w3-container'><b>" + name + "</b><br>";

    var icons = {
        'Electricity': 'fas fa-bolt',
        'Gas': 'fas fa-fire',
        'Oil': 'fas fa-oil-can'
    };

    Object.keys(prices).forEach(function (energyType) {
        if (prices[energyType] !== null && prices[energyType] !== undefined) {
            popupContent += "<p><i class='" + icons[energyType] + "'></i> " + energyType + " Price: <span class='w3-text-blue'>" + prices[energyType] + " CHF</span></p>";
        }
    });

    popupContent += "</div>";

    var marker = L.marker([lat, lng]).addTo(map);
    marker.bindPopup(popupContent).openPopup();
}

document.addEventListener("DOMContentLoaded", function () {
    var mymap = initializeMap();

    var mapElements = Array.from(document.getElementsByClassName("marker-data"));

    mapElements.forEach(function (element) {
        var lat = element.getAttribute('data-lat');
        var lng = element.getAttribute('data-lng');
        var name = element.getAttribute('data-name');
        var prices = {
            'Electricity': element.getAttribute('data-electricity-price'),
            'Gas': element.getAttribute('data-gas-price'),
            'Oil': element.getAttribute('data-oil-price')
        };

        addMarkerToMap(mymap, lat, lng, name, prices);
    });
});
