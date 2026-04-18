import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-variants"
export default class extends Controller {

  static targets = [ "price", "cartForm", "option" ]
  static values = { variants: Array }
  getPrice (event) {
    const variantId = parseInt(event.currentTarget.dataset.variantId)
    this.selectVariant(variantId)
  }

  connect() {
    this.selectVariant(this.variantsValue[0].id)
  }

  selectVariant(variantId) {
    const variant = this.variantsValue.find(v => v.id === variantId)
    this.optionTargets.forEach(btn => {
      btn.classList.toggle("btn-dark", btn.dataset.variantId === String(variantId))
      btn.classList.toggle("btn-outline-dark", btn.dataset.variantId !== String(variantId))
    })
    if (!variant) return

    this.priceTarget.textContent = "Rs." + variant.price
    this.cartFormTarget.innerHTML = `
    <form action="/cart/add/${variant.id}" method="post" data-turbo="false">
      <input type="hidden" name="authenticity_token" value="${document.querySelector('meta[name=csrf-token]').content}" />
      <button type="submit" class="btn btn-dark btn-lg px-5 mt-2">Add to Cart</button>
    </form>`
  }
}
