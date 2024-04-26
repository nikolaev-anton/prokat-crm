function submitForm() {
    const form = document.getElementById('form');
    const formData = new FormData(form);
    const json = {};

   const selectElement = document.getElementById('goods');
   const selectedValue = selectElement.value;
   formData.append('goods', '[{model_id: ' + selectedValue + '}]');

formData.forEach((value, key) => {
        json[key] = value;
    });

//document.getElementById('output').textContent = JSON.stringify(json);

const url = `https://prokat-palatok.ru/crm2/create_order.php?request=${JSON.stringify(json)}`;
console.log(url);


fetch(url, {
  method: 'GET',
  mode: 'no-cors'
})
.then(response => {
  if (response.ok) {
    return response.text();
  } else {
    throw new Error('Failed to send GET request');
  }
})
}
