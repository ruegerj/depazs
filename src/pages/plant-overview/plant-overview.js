let cantonsLayer;

async function initializeMap() {
    const map = L.map('map').setView([46.8182, 8.2275], 8);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
    }).addTo(map);

    // Load GeoJSON for Swiss cantons
    try {
        const response = await fetch('/plant-overview/plant-overview.geojson');
        const data = await response.json();
        cantonsLayer = L.geoJson(data, {
            style: {
                weight: 1,
                opacity: 1,
                color: 'black',
                fillOpacity: 0,
            }
        }).addTo(map);
        return map;
    } catch (error) {
        console.error('Error initializing map:', error);
    }
}

function addMarkerToMap(map, lat, lng, name, prices) {
    const icons = {
        Electricity: 'fas fa-bolt',
        Gas: 'fas fa-fire',
        Oil: 'fas fa-oil-can',
    };

    const formattedPrices = Object.entries(prices)
        .map(([energyType, price]) => {
            if (price !== null && price !== undefined) {
                return `<p><i class='${icons[energyType]}'></i> ${energyType} Price: <span class='w3-text-blue'>${price} CHF</span></p>`;
            }
            return '';
        })
        .join('');

    const popupContent = `<div class='w3-container'><b>${name}</b><br>${formattedPrices}</div>`;

    const marker = L.marker([lat, lng]).addTo(map);
    marker.bindPopup(popupContent);
}

function recolorCantons(cantons, color) {
    if (!cantonsLayer) return;

    cantonsLayer.eachLayer(layer => {
        if (cantons.includes(layer.feature.properties.KUERZEL)) {
            layer.setStyle({ fillColor: color, fillOpacity: 0.5 });
        }
    });
}

document.addEventListener('DOMContentLoaded', async () => {
    const map = await initializeMap();
    const mapElements = Array.from(document.getElementsByClassName('plant-data'));
    const colors = ['green', 'blue', 'red', 'yellow', 'orange', 'purple', 'pink', 'brown', 'grey', 'cyan', 'magenta', 'lime'];

    mapElements.forEach((element, index) => {
        const { lat, lng, name, electricityPrice, gasPrice, oilPrice, cantons } = element.dataset;
        const prices = { Electricity: electricityPrice, Gas: gasPrice, Oil: oilPrice };
        const cantonList = cantons.split('\n').map(canton => canton.trim()).filter(Boolean);

        addMarkerToMap(map, lat, lng, name, prices);
        recolorCantons(cantonList, colors[index % colors.length]);
    });
});
