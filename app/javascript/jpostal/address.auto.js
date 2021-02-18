$(function() {
  return $('#cloth_store_postcode').jpostal({
    postcode: ['#cloth_store_postcode'],
    address: {
      '#cloth_store_prefecture_code': '%3',
      '#cloth_store_address_city': '%4%5',
      '#cloth_store_address_street': '%6%7',
    },
  });
});