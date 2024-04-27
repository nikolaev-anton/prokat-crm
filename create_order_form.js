function goodsToJson() {
    const goods = [];
    
    // Получаем все элементы <select> и <input type="number">
    const selectElements = document.querySelectorAll('select[id^="good_"]');
    const input_elements_count = document.querySelectorAll('input[type="number"][id^="good_count_"]');
    const input_elements_price = document.querySelectorAll('input[type="number"][id^="good_price_"]');
    const input_elements_deposit = document.querySelectorAll('input[type="number"][id^="good_deposit_"]');
    
    // Проходим по каждому элементу и собираем данные
    selectElements.forEach((selectElement, index) => {
        const model_id = selectElement.value;
        const count = input_elements_count[index].value;
        const price = input_elements_price[index].value;
        const deposit = input_elements_deposit[index].value;
        if(model_id === "" || count === "" || price === "" || deposit === "") {return;}

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
//    console.log(JSON.stringify(goods));
    return(goods);
}

function submitForm() {
    // сбор полей и их значений в JSON
    const form = document.getElementById('form');
    const formData = new FormData(form);
    const json = {};
    formData.forEach((value, key) => {
        json[key] = value;
     });

    // сбор полей и их значений по товарам вынесен в отдельную функцию
    goods = goodsToJson();
    json["goods"] = goods;

    // вывод JSON в конце экрана
    document.getElementById('output').textContent = JSON.stringify(json);

    const url = `https://prokat-palatok.ru/crm2/create_order.php?request=${JSON.stringify(json)}`;
    console.log(url);

    // собственно отправка JSON на сервер
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


function create_goods_select_inputs(i) {
// создание элемента SELECT по выдаче товаров из MODELS и их id
fetch('https://prokat-palatok.ru/crm2/get_goods.php')
  .then(response => response.json())
  .then(data => {
const jsonData = data;
const li = document.getElementById('goods_li');
const selectElement = document.createElement('select');
selectElement.id = `good_${i}`;
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
good_count_input_element.id = `good_count_${i}`;
good_count_input_element.placeholder="Кол-во"
li.appendChild(good_count_input_element);

// сумма аренды по этим товарам
const good_price_input_element = document.createElement('input');
good_price_input_element.type = 'number';
good_price_input_element.id = `good_price_${i}`;
good_price_input_element.placeholder="Аренда"
li.appendChild(good_price_input_element);

// количество этих товаров в заказе
const good_deposit_input_element = document.createElement('input');
good_deposit_input_element.type = 'number';
good_deposit_input_element.id = `good_deposit_${i}`;
good_deposit_input_element.placeholder="Залог"
li.appendChild(good_deposit_input_element);

const good_plus_button = document.createElement('button');
//good_plus_button.onclick=handleAddButtonClick;
good_plus_button.id = `good_plus_button_${i}`;
good_plus_button.innerText = "+";
li.appendChild(good_plus_button);
// Добавляем обработчик события click
good_plus_button.addEventListener("click", function(event) {
    // Предотвращаем отправку формы
    event.preventDefault();
//    console.log("Клик на кнопку good_plus_button_1");
    handleAddButtonClick();
});

  })
  .catch(error => console.error('Error:', error));
return(0);
}

function handleAddButtonClick() {
  let i = 3; // начальное значение i
  create_goods_select_inputs(i);
  i++; // увеличение значения i
  return(0);
}