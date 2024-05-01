fetch('https://prokat-palatok.ru/crm2/list_orders.php')
  .then(response => response.json())
  .then(data => {
    data.orders.forEach(orderId => {

console.log(orderId);
console.log(`https://prokat-palatok.ru/crm2/get_order_details.php?request={"order_id":"${orderId}"}`);

      fetch(`https://prokat-palatok.ru/crm2/get_order_details.php?request={"order_id":"${orderId}"}`)
      .then(response => response.json())
      .then(orderData => {
        if (!orderData.error) {
          const order = orderData.order;
          const tableRow = document.createElement('tr');
          tableRow.innerHTML = `
            <td>${order.id}</td>
            <td>${order.status}</td>
            <td>${order.client_id}</td>
            <td>${order.created}</td>
            <td>${order.begin}</td>
            <td>${order.end}</td>
            <td>${order.total_amount}</td>
            <td>${order.total_deposit}</td>
          `;
          document.querySelector('#ordersTable tbody').appendChild(tableRow);
        }
      });
    });
  });