document
.getElementById("submit-statistique-parite")
.addEventListener('click', function() {
  fetchStatistiqueParite(
    document.getElementById('annee-select').value
  )
})

const fetchStatistiqueParite = (annee_id) => {
    fetch(`/statistique/parite?annee_id=${annee_id}`)
      .then(response => response.text())
      .then(data => {
        const result = JSON.parse(data);
        totalBoyChart.series[0].update({
            data: createMapData(result, 'nombre_garcon')
        }, false);
        totalBoyChart.redraw();

        totalFilleChart.series[0].update({
            data: createMapData(result, 'nombre_fille')
        }, false);
        totalFilleChart.redraw();
    })
}


const totalBoyChart = Highcharts.mapChart('container-garcon', {
  chart: {
      map: 'countries/fr/fr-all-all'
  },

  title: {
      text: 'Répartition géographique des collégiens'
  },

  subtitle: {
      text: 'Source map: <a href="http://code.highcharts.com/mapdata/countries/fr/fr-all-all.js">France, admin2</a>'
  },

  mapNavigation: {
      enabled: true,
      buttonOptions: {
          verticalAlign: 'bottom'
      }
  },

  colorAxis: {
      min: 0
  },

  series: [{
      data: [],
      name: 'Collégien',
      states: {
          hover: {
              color: '#BADA55'
          }
      },
      dataLabels: {
          enabled: true,
          format: '{point.name}'
      }
  }, {
      name: 'Separators',
      type: 'mapline',
      data: Highcharts.geojson(Highcharts.maps['countries/fr/fr-all-all'], 'mapline'),
      color: 'silver',
      nullColor: 'silver',
      showInLegend: false,
      enableMouseTracking: false
  }]
});

const totalFilleChart = Highcharts.mapChart('container-fille', {
    chart: {
        map: 'countries/fr/fr-all-all'
    },
  
    title: {
        text: 'Répartition géographique des collégiennes'
    },
  
    subtitle: {
        text: 'Source map: <a href="http://code.highcharts.com/mapdata/countries/fr/fr-all-all.js">France, admin2</a>'
    },
  
    mapNavigation: {
        enabled: true,
        buttonOptions: {
            verticalAlign: 'bottom'
        }
    },
  
    colorAxis: {
        min: 0
    },
  
    series: [{
        data: [],
        name: 'Nombre de collégienne dans ce département',
        states: {
            hover: {
                color: '#BADA55'
            }
        },
        dataLabels: {
            enabled: true,
            format: '{point.name}'
        }
    }, {
        name: 'Separators',
        type: 'mapline',
        data: Highcharts.geojson(Highcharts.maps['countries/fr/fr-all-all'], 'mapline'),
        color: 'silver',
        nullColor: 'silver',
        showInLegend: false,
        enableMouseTracking: false
    }]
  });