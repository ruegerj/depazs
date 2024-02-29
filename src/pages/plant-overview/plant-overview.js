let cantonsLayer;

function initializeMap() {
    const map = L.map('map').setView([46.8182, 8.2275], 8);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);

    // load GeoJSON for swiss cantons
    return fetch('/plant-overview/plant-overview.geojson')
        .then(response => response.json())
        .then(data => {
            cantonsLayer = L.geoJson(data, {
                style: function (feature) {
                    return {
                        weight: 1,
                        opacity: 1,
                        color: 'black',
                    };
                }
            }).addTo(map);

            return map;
        });
}

function addMarkerToMap(map, lat, lng, name, prices) {
    let popupContent = "<div class='w3-container'><b>" + name + '</b><br>';

    const icons = {
        Electricity: 'fas fa-bolt',
        Gas: 'fas fa-fire',
        Oil: 'fas fa-oil-can',
    };

    Object.keys(prices).forEach(function (energyType) {
        if (prices[energyType] !== null && prices[energyType] !== undefined) {
            popupContent +=
                "<p><i class='" +
                icons[energyType] +
                "'></i> " +
                energyType +
                " Price: <span class='w3-text-blue'>" +
                prices[energyType] +
                ' CHF</span></p>';
        }
    });

    popupContent += '</div>';

    const marker = L.marker([lat, lng]).addTo(map);
    marker.bindPopup(popupContent);
}

function recolorCantons(cantons, color) {
    if (!cantonsLayer) return;

    cantonsLayer.eachLayer(function (layer) {
        if (cantons.includes(layer.feature.properties.KUERZEL)) {
            layer.setStyle({ fillColor: color, fillOpacity: 0.7});
        }
    });
}

document.addEventListener('DOMContentLoaded', function () {
    initializeMap().then(map => {
        const mapElements = Array.from(
            document.getElementsByClassName('marker-data'),
        );

        const colors = ['green', 'blue', 'red', 'yellow', 'orange', 'purple', 'pink', 'brown', 'grey', 'cyan', 'magenta', 'lime'];

        mapElements.forEach(function (element, index) {
            const lat = element.dataset.lat;
            const lng = element.dataset.lng;
            const name = element.dataset.name;

            const prices = {
                Electricity: element.dataset.electricityPrice,
                Gas: element.dataset.gasPrice,
                Oil: element.dataset.oilPrice,
            };

            addMarkerToMap(map, lat, lng, name, prices);

            const cantons = element.dataset.cantons.split('\n').map(canton => canton.trim()).filter(Boolean);
            recolorCantons(cantons, colors[index % colors.length]);
        });
    });
});
