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
    if (this.variantsValue.length > 0) {
      this.selectVariant(this.variantsValue[0].id)
    }
  }

  selectVariant(variantId) {
    const variant = this.variantsValue.find(v => v.id === variantId)
    this.optionTargets.forEach(btn => {
      btn.classList.toggle("btn-dark", btn.dataset.variantId === String(variantId))
      btn.classList.toggle("btn-outline-dark", btn.dataset.variantId !== String(variantId))
    })
    if (!variant) return

    this.priceTarget.textContent = "Rs. " + variant.price
    if (variant.stock === 0) {
      this.cartFormTarget.innerHTML = `<button class="btn btn-secondary px-5" disabled>Out of Stock</button>`
    } else {
      this.cartFormTarget.innerHTML = 
      `<form action="/cart/add/${variant.id}" method="post" data-turbo="false">
        <input type="hidden" name="authenticity_token" value="${document.querySelector('meta[name=csrf-token]').content}" />
        <input type="hidden" name="quantity" id="quantity-input" value="1" />
        <div class="d-flex align-items-center gap-3 mt-3 mb-3">
          <button type="button" class="btn btn-outline-dark px-3" onclick="
            const q = document.getElementById('quantity-input');
            const s = document.getElementById('quantity-display');
            if (parseInt(q.value) > 1) { q.value = parseInt(q.value) - 1; s.textContent = q.value; }
          ">−</button>
          <span id="quantity-display">1</span>
          <button type="button" class="btn btn-outline-dark px-3" onclick="
            const q = document.getElementById('quantity-input');
            const s = document.getElementById('quantity-display');
            q.value = parseInt(q.value) + 1; s.textContent = q.value;
          ">+</button>
        </div>
        <button type="submit" class="btn btn-dark px-5">Add to Cart</button>
      </form>`
    }
  }
}
