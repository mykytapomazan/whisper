import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="post-form"
export default class extends Controller {
    static targets = ['body', 'submit']

    connect() {
        this.resetHeight()
        this.checkLength()

        if (this.hasBodyTarget) {
            this.bodyTarget.addEventListener('input', () => {
                this.checkLength()
                this.adjustHeight()
            })
        }
    }

    checkLength() {
        const trimmedValue = this.bodyTarget.value.trim()
        this.submitTarget.disabled = trimmedValue.length < 3

        if (trimmedValue.length < 3) {
            this.bodyTarget.setCustomValidity('Please enter at least 3 characters.')
        } else {
            this.bodyTarget.setCustomValidity('')
        }
    }

    adjustHeight() {
        const minRows = 3
        const maxRows = 12

        this.bodyTarget.style.height = 'auto'
        const scrollHeight = this.bodyTarget.scrollHeight
        const lineHeight = parseInt(window.getComputedStyle(this.bodyTarget).lineHeight, 10)
        const rows = Math.floor(scrollHeight / lineHeight)

        if (rows > maxRows) {
            this.bodyTarget.style.height = `${lineHeight * maxRows}px`
            this.bodyTarget.style.overflowY = 'auto'
        } else {
            this.bodyTarget.style.height = `${scrollHeight}px`
            this.bodyTarget.style.overflowY = 'hidden'
        }
    }

    resetForm() {
        if (this.hasBodyTarget) {
            this.bodyTarget.value = ''
            this.submitTarget.disabled = true
            this.resetHeight()
        }
    }

    resetHeight() {
        this.bodyTarget.style.height = 'auto'
        this.adjustHeight()
    }

    submitEnd(event) {
        if (event.detail.success) {
            this.resetForm()
            this.closeModal()
        }
    }

    closeModal() {
        const modal = this.element.closest('.modal')
        if (modal) {
            const closeButton = modal.querySelector('.btn-close')
            if (closeButton) {
                closeButton.click()
            }
        }
    }
}
