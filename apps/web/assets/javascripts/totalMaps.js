document
.getElementById("submit-statistique-parite")
.addEventListener('click', function() {
  fetchStatistiqueParite(
    document.getElementById('annee-select').value,
    document.getElementById('niveau-select').value,
  )
})

const fetchStatistiqueParite = (annee_id, niveau) => {
    fetch(`/statistique/parite?annee_id=${annee_id}&niveau=${niveau}`)
      .then(response => response.text())
      .then(data => {
        const result = JSON.parse(data);
        totalBoyChart.series[0].update({
            data: createGenderRepartitionData(result, ['nombre_garcon', 'nombre_fille', 'nombre_total'])
        }, false);
        totalBoyChart.redraw();
    })
}


const totalBoyChart = Highcharts.mapChart('container-garcon', {
  chart: {
      map: 'countries/fr/fr-all-all'
  },

  title: {
      text: 'Répartition démographique par genre des collégiens'
  },

  subtitle: {
      text: 'Source: <a href="https://data.education.gouv.fr/explore/dataset/fr-en-college-effectifs-niveau-sexe-lv/table/?disjunctive.rentree_scolaire&disjunctive.region_academique&disjunctive.academie&disjunctive.departement&disjunctive.commune&disjunctive.numero_college&disjunctive.denomination_principale&disjunctive.patronyme&disjunctive.secteur&disjunctive.rep&disjunctive.rep_plus">Education.gouv</a>'
  },

  colorAxis: {
    dataClasses: [{
        to: -1501,
        color: '#C40401',
        name: 'Victoire totale - Fille'
    },{
        from: -1500,
        to: -1001,
        color: '#ff5754',
        name: 'Victoire modérée - Fille'
    }, {
        from: -1000,
        to: -501,
        color: '#fd9290',
        name: 'Victoire - Fille',
    }, {
        from: -500,
        to: 500,
        color: '#f1eded',
        name: 'Egalité',
    }, {
        from: 501,
        to: 1000,
        color: '#9691ff',
        name: 'Victoire - Garcon',
    }, {
        from: 1001,
        to: 1500,
        color: '#5b53ff',
        name: 'Victoire modérée - Garcon',
    }, {
        from: 1501,
        color: '#0c00ff',
        name: 'Victoire totale - Garcon',
    }]
  },

  legend: {
    enabled: true

  },
  mapNavigation: {
      enabled: true,
      buttonOptions: {
          verticalAlign: 'bottom'
      }
  },

  series: [{
      data: [],
      name: 'Différence nombre de garçon et fille',
      states: {
          hover: {
              color: '#BADA55'
          }
      },
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
