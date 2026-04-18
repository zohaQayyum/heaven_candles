import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-variants"
export default class extends Controller {

  static targets = [ "price", "cartForm" ]
  static values = { variants: Array }
  getPrice (event) {
    const variantId = parseInt(event.currentTarget.dataset.variantId)
    this.selectVariant(variantId)
  }

  connect(){
    this.priceTarget.textContent = this.variantsValue[0].price
    console.log('event', this.variantsValue[0].price)
  }

  selectVariant(variantId) {
    const variant = this.variantsValue.find(v => v.id === variantId)
    if (!variant) return

    this.priceTarget.textContent = variant.price
    this.cartFormTarget.innerHTML = `
    <form action="/cart/add/${variant.id}" method="post" data-turbo="false">
      <input type="hidden" name="authenticity_token" value="${document.querySelector('meta[name=csrf-token]').content}" />
      <button type="submit" class="btn btn-dark btn-lg px-5 mt-2">Add to Cart</button>
    </form>`
  }
}
