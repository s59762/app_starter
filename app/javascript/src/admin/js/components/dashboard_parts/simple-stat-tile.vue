<template lang="pug">

.dashboard-parts-simple-stat-tile.tile.is-parent(:class="tileClass")
  .tile.is-child.notification
    .icon
      i.fa(:class="iconClass")
    .content-wrapper(data-behavior="content-wrapper")
      .inner
        .stat-info-wrapper
          .stat
            span.numbers
            span.unit / {{unit}}
          .title {{title}}


</template>

<script>
import debounce from 'lodash.debounce'
import { ResizeSensor } from 'css-element-queries'
import CountUp from 'countup.js'

const DEFAULT_STYLE = {
  width: 160,
  iconFontSize: 10,
  iconOffset: 3,
  numberFontSize: 1.5,
  unitFontSize: 0.8,
  titleFontSize: 1.2,
  statMarginBottom: 1.5
}

export default {
  // components: {},
  // mixins: [],
  props: {
    size: {
      type: String,
      default: null
    },

    icon: {
      type: String,
      default: 'line-chart'
    },

    type: {
      type: String,
      default: 'primary'
    },

    title: {
      type: String,
      default: 'Title'
    },

    unit: {
      type: String,
      default: 'Orders'
    },

    number: {
      type: [String, Number],
      default: 0
    }
  },
  // data() {
  //   return {}
  // },
  computed: {
    iconElement() {
      return this.$el.querySelector('.notification .icon')
    },

    numbersElement() {
      return this.$el.querySelector('.notification .numbers')
    },

    unitElement() {
      return this.$el.querySelector('.stat-info-wrapper .unit')
    },

    titleElement() {
      return this.$el.querySelector('.stat-info-wrapper .title')
    },

    iconClass() {
      return `fa-${this.icon}`
    },

    tileClass() {
      if (this.size) {
        return `is-${this.type} is-${this.size}`
      } else {
        return `is-${this.type}`
      }
    },

    normalizedNumber() {
      return Number(this.number)
    },

    counter() {
      return new CountUp(this.numbersElement, 0, this.normalizedNumber)
    }
  },
  // created() {},
  mounted() {
    new ResizeSensor(this.$el, debounce(this.adjustSize, 200))
    this.adjustSize()
    this.countUp()
  },

  methods: {
    adjustSize() {
      this.iconElement.style.fontSize = `${DEFAULT_STYLE.iconFontSize * this.calculateSizeRatio()}rem`
      this.iconElement.style.transform = `translate(${DEFAULT_STYLE.iconOffset *
        this.calculateSizeRatio()}rem, -${DEFAULT_STYLE.iconOffset * this.calculateSizeRatio()}rem)`
      this.numbersElement.style.fontSize = `${DEFAULT_STYLE.numberFontSize * this.calculateSizeRatio()}rem`
      this.unitElement.style.fontSize = `${DEFAULT_STYLE.unitFontSize * this.calculateSizeRatio()}rem`
      this.titleElement.style.fontSize = `${DEFAULT_STYLE.titleFontSize * this.calculateSizeRatio()}rem`
    },

    calculateCurrentWidth() {
      return this.$el.offsetWidth
    },

    calculateSizeRatio() {
      return this.calculateCurrentWidth() / DEFAULT_STYLE.width
    },

    countUp() {
      this.counter.start()
    }
  }
}
</script>
