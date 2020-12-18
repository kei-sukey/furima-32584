 function commission (){
  const itemPrice = document.getElementById("item-price");

  itemPrice.addEventListener("keyup", () => {
    const price = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const tax = `${Math.round(price * 0.1)}`;
    addTaxPrice.innerHTML = Number(tax).toLocaleString();
    const profit = document.getElementById("profit");
    profit.innerHTML = Number(price - tax).toLocaleString();
  });
}

window.addEventListener('load', commission)