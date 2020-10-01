export class SwipeEventDispatcher {
  constructor(element, options = {}) {
    this.evtMap = {
      SWIPE_DOWN: [],
      SWIPE_LEFT: [],
      SWIPE_RIGHT: [],
      SWIPE_UP: [],
    }
    this.xDown = null
    this.yDown = null
    this.element = element
    this.options = Object.assign({ triggerPercent: 0.3 }, options)
    element.addEventListener(
      'touchstart',
      (evt) => {
        return this.handleTouchStart(evt)
      },
      false
    )
    element.addEventListener(
      'touchend',
      (evt) => {
        return this.handleTouchEnd(evt)
      },
      false
    )
  }
  on(evt, cb) {
    this.evtMap[evt].push(cb)
  }
  off(evt, lcb) {
    this.evtMap[evt] = this.evtMap[evt].filter((cb) => {
      return cb !== lcb
    })
  }
  trigger(evt, data) {
    this.evtMap[evt].map((handler) => {
      return handler(data)
    })
  }
  handleTouchStart(evt) {
    this.xDown = evt.touches[0].clientX
    this.yDown = evt.touches[0].clientY
  }
  handleTouchEnd(evt) {
    const deltaX = evt.changedTouches[0].clientX - this.xDown
    const deltaY = evt.changedTouches[0].clientY - this.yDown
    const distMoved = Math.abs(Math.abs(deltaX) > Math.abs(deltaY) ? deltaX : deltaY)
    const activePct = distMoved / this.element.offsetWidth
    if (activePct > this.options.triggerPercent) {
      if (Math.abs(deltaX) > Math.abs(deltaY)) {
        deltaX < 0 ? this.trigger('SWIPE_LEFT') : this.trigger('SWIPE_RIGHT')
      } else {
        deltaY > 0 ? this.trigger('SWIPE_DOWN') : this.trigger('SWIPE_UP')
      }
    }
  }
}
export default SwipeEventDispatcher
