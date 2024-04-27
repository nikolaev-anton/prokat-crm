function goodsToJson() {
    const goods = [];
    
    // Получаем все элементы <select> и <input type="number">
    const selectElements = document.querySelectorAll('select[id^="good_"]');
    const input_elements_count = document.querySelectorAll('input[type="number"][id^="good_count_"]');
    const input_elements_price = document.querySelectorAll('input[type="number"][id^="good_price_"]');
    const input_elements_deposit = document.querySelectorAll('input[type="number"][id^="good_deposit_"]');
//    const inputElements = document.querySelectorAll('input[type="number"][id^="good_"]');
    
    // Проходим по каждому элементу и собираем данные
    selectElements.forEach((selectElement, index) => {
        const model_id = selectElement.value;
        const count = input_elements_count[index].value;
        const price = input_elements_price[index].value;
        const deposit = input_elements_deposit[index].value;
        
        // Формируем объект и добавляем его в массив goods
        const item = {
            "model_id": model_id,
            "count": count,
            "price": price,
            "deposit": deposit
        };
        goods.push(item);
    });
    
    // выводим и возвращаем JSON
    console.log(JSON.stringify(goods));
    return(goods);
}

function submitForm() {
    const form = document.getElementById('form');
    const formData = new FormData(form);
    const json = {};

    goods = goodsToJson();

//   const selectElement = document.getElementById('goods');
//   const selectedValue = selectElement.value;
//   formData.append('goods', JSON.stringify(goods));

   formData.forEach((value, key) => {
        json[key] = value;
    });
   json["goods"] = goods;
document.getElementById('output').textContent = JSON.stringify(json);

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



function create_goods_select_inputs() {
// создание элемента SELECT по выдаче товаров из MODELS и их id
fetch('https://prokat-palatok.ru/crm2/get_goods.php')
  .then(response => response.json())
  .then(data => {
const jsonData = data;
const li = document.getElementById('goods_li');
const selectElement = document.createElement('select');
selectElement.id = 'good_1';
const defaultOption = document.createElement('option');
defaultOption.text = 'Выберите товар';
defaultOption.value = '';
selectElement.add(defaultOption);
jsonData.goods.forEach(item => {
  const optionElement = document.createElement('option');
  optionElement.value = item.id;
  optionElement.text = item.name;
  selectElement.appendChild(optionElement);
});

li.appendChild(selectElement);
// количество этих товаров в заказе
const good_count_input_element = document.createElement('input');
good_count_input_element.type = 'number';
good_count_input_element.id = 'good_count_1';
good_count_input_element.placeholder="Кол-во"
li.appendChild(good_count_input_element);

// сумма аренды по этим товарам
const good_price_input_element = document.createElement('input');
good_price_input_element.type = 'number';
good_price_input_element.id = 'good_price_1';
good_price_input_element.placeholder="Аренда"
li.appendChild(good_price_input_element);

// количество этих товаров в заказе
const good_deposit_input_element = document.createElement('input');
good_deposit_input_element.type = 'number';
good_deposit_input_element.id = 'good_deposit_1';
good_deposit_input_element.placeholder="Залог"
li.appendChild(good_deposit_input_element);

  })
  .catch(error => console.error('Error:', error));
return(0);
}
