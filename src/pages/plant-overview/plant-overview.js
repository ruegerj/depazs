function initializeMap() {
    const map = L.map('map').setView([46.8182, 8.2275], 8);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);

    return map;
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

document.addEventListener('DOMContentLoaded', function () {
    const map = initializeMap();

    const mapElements = Array.from(
        document.getElementsByClassName('marker-data'),
    );

    mapElements.forEach(function (element) {
        const lat = element.dataset.lat;
        const lng = element.dataset.lng;
        const name = element.dataset.name;

        const prices = {
            Electricity: element.dataset.electricityPrice,
            Gas: element.dataset.gasPrice,
            Oil: element.dataset.oilPrice,
        };

        addMarkerToMap(map, lat, lng, name, prices);
    });
});
