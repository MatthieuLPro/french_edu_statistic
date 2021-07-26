const createSelectOptions = (id, data) => {
  const select = document.getElementById(id);
  for(const [key, value] of Object.entries(data)) {
    let newOption = document.createElement('option');
    newOption.value = value;
    newOption.innerHTML = key;
    select.appendChild(newOption);
  }
}

const fetchAnnees = () => {
  fetch('/annees')
  .then(response => response.text())
  .then(data => {
    createSelectOptions('annee-select', JSON.parse(data));
  })
}

fetchAnnees();