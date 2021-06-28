fetch('/annees')
.then(response => response.text())
.then(data => {
  const select = document.getElementById('annee-select');
  for(const [key, value] of Object.entries(JSON.parse(data))) {
    let newOption = document.createElement('option');
    newOption.value = value;
    newOption.innerHTML = key;
    select.appendChild(newOption);
  }
})

fetch('/departements')
.then(response => response.text())
.then(data => {
  const select = document.getElementById('departement-select');
  for(const [key, value] of Object.entries(JSON.parse(data))) {
    let newOption = document.createElement('option');
    newOption.value = value;
    newOption.innerHTML = key;
    select.appendChild(newOption);
  }
})

document
  .getElementById("submit-statistique-parite")
  .addEventListener('click', function() {
    fetch('/statistique/parite', { method: 'POST', body: { annee_id: 1, departement: 'AIN' }, headers: new Headers() })
      .then(response => response.text())
      .then(data => {
        console.log(data);
      })
  })
