const createSelectOptions = (id, data) => {
  const select = document.getElementById(id);
  for(const [key, value] of Object.entries(data)) {
    let newOption = document.createElement('option');
    newOption.value = value;
    newOption.innerHTML = key;
    select.appendChild(newOption);
  }
}

const getAnnees = () => {
  fetch('/annees')
  .then(response => response.text())
  .then(data => {
    createSelectOptions('annee-select', JSON.parse(data));
  })
}

const getDepartements = () => {
  fetch('/departements')
  .then(response => response.text())
  .then(data => {
    createSelectOptions('departement-select', JSON.parse(data));
  })
}

const getNiveaux = () => {
  fetch('/niveaux')
  .then(response => response.text())
  .then(data => {
    createSelectOptions('niveau-select', JSON.parse(data));
  })
}

const getStatistiqueParite = (annee_id, departement, niveau) => {
  fetch(`/statistique/parite?annee_id=${annee_id}&departement=${departement}&niveau=${niveau}`)
    .then(response => response.text())
    .then(data => {
      const result = JSON.parse(data);
      document.getElementById("nombre-fille").innerHTML = result["nombre_fille"];
      document.getElementById("nombre-garcon").innerHTML = result["nombre_garcon"];
    })
}

getAnnees();
getDepartements();
getNiveaux();

document
.getElementById("submit-statistique-parite")
.addEventListener('click', function() {
  getStatistiqueParite(
    document.getElementById('annee-select').value,
    document.getElementById('departement-select').value,
    document.getElementById('niveau-select').value
  )
})
