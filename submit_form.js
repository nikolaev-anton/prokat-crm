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

