import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["code", "message", "discountDisplay", "hiddenCode", "total"]
  static values = { originalTotal: Number }

  apply() {
    const code = this.codeTarget.value.trim()
    if (!code) return

    fetch("/coupons/apply", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name=csrf-token]').content
      },
      body: JSON.stringify({ code })
    })
      .then(res => res.json())
      .then(data => this.handleResponse(data))
      .catch((error) => {
        console.error('Fetch error:', error)
        this.showMessage("Something went wrong. Please try again.", "error")
      })
  }

  handleResponse(data) {
    if (data.status === "success") {
      const original = this.originalTotalValue
      const discount = data.discount_value
      let discountedTotal, label

      if (data.discount_type === "percentage") {
        discountedTotal = original - (original * discount / 100)
        label = `${discount}% off applied!`
      } else {
        discountedTotal = original - discount
        label = `Rs. ${discount} off applied!`
      }

      this.totalTarget.textContent = `Rs. ${discountedTotal.toFixed(2)}`
      this.showMessage(label, "success")
      this.hiddenCodeTarget.value = this.codeTarget.value
      const formInput = document.getElementById('form-coupon-code')
      if (formInput) formInput.value = this.codeTarget.value
    } else {
      this.showMessage(data.message, "error")
    }
    console.log("original total:", this.originalTotalValue)
    console.log("data:", data)
  }

  showMessage(text, type) {
    this.discountDisplayTarget.innerText = text
    this.discountDisplayTarget.className = type === "success" ? "text-success small" : "text-danger small"
  }

  clear() {
    this.codeTarget.value = ""
    this.discountDisplayTarget.innerText = ""
    this.hiddenCodeTarget.value = ""
    this.totalTarget.textContent = `Rs. ${this.originalTotalValue.toFixed(2)}`
    const formInput = document.getElementById('form-coupon-code')
    if (formInput) formInput.value = ""
  }
}
