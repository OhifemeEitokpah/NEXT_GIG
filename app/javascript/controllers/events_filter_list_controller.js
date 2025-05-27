import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="events-filter-list"
export default class extends Controller {
  static targets = ["list", "thisWeek", "nextWeek", "allList"]

  connect() {}

  this_week() {
    this.filterByWeek(0)
    this.thisWeekTarget.classList.replace("btn-outline-secondary", "btn-outline-primary")
    this.nextWeekTarget.classList.replace("btn-outline-primary", "btn-outline-secondary")
    this.allListTarget.classList.replace("btn-outline-primary", "btn-outline-secondary")
  }

  next_week() {
    this.filterByWeek(1)
    this.nextWeekTarget.classList.replace("btn-outline-secondary", "btn-outline-primary")
    this.thisWeekTarget.classList.replace("btn-outline-primary", "btn-outline-secondary")
    this.allListTarget.classList.replace("btn-outline-primary", "btn-outline-secondary")
  }

  filterByWeek(weekOffset) {
    const today = new Date()
    const startOfWeek = new Date(today)
    startOfWeek.setDate(today.getDate() - today.getDay())

    const start = new Date(startOfWeek)
    start.setDate(start.getDate() + weekOffset * 7)
    const end = new Date(start)
    end.setDate(end.getDate() + 7)

    this.cards.forEach(card => {
      const eventDate = new Date(card.dataset.eventDate)
      if (eventDate >= start && eventDate < end) {
        card.classList.remove("d-none")
      } else {
        card.classList.add("d-none")
      }
    })
  }

  all() {
    this.cards.forEach(card => card.classList.remove("d-none"))
    this.allListTarget.classList.replace("btn-outline-secondary", "btn-outline-primary")
    this.thisWeekTarget.classList.replace("btn-outline-primary", "btn-outline-secondary")
    this.nextWeekTarget.classList.replace("btn-outline-primary", "btn-outline-secondary")
  }

  get cards() {
    return this.element.querySelectorAll(".event-card")
  }
}
