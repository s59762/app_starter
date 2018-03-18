<template lang="pug">

.dashboard-parts-simple-stat-tile.tile.is-parent(:class="tileClass")
  .tile.is-child.notification
    .icon
      i.fa(:class="iconClass")
    .content-wrapper(data-behavior="content-wrapper")
      .inner
        .stat-info-wrapper
          .stat
            span.numbers {{number}}
            span.unit / {{unit}}
          .title {{title}}


</template>

<script>
import debounce from 'lodash.debounce'
import { ResizeSensor } from 'css-element-queries'

const DEFAULT_STYLE = {
  width: 160,
  iconFontSize: 10,
  iconOffset: 3,
  numberFontSize: 2,
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
      default: ''
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
      type: Number,
      default: 0
    }
  },

  // data() {
  //   return {}
  // },

  computed: {
    sizeClass() {
      if (this.size) {
        return `is-${this.size}`
      }
    },

    iconClass() {
      return `fa-${this.icon}`
    },

    tileClass() {
      return `is-${this.type} ${this.sizeClass}`
    },

    iconStyle() {
      return this.$el.querySelector('.notification .icon').style
    },

    numbersStyle() {
      return this.$el.querySelector('.notification .numbers').style
    },

    unitStyle() {
      return this.$el.querySelector('.stat-info-wrapper .unit').style
    },

    titleStyle() {
      return this.$el.querySelector('.stat-info-wrapper .title').style
    }
  },
  // created() {},
  mounted() {
    new ResizeSensor(this.$el, debounce(this.adjustSize, 200))
    this.adjustSize()
  },

  methods: {
    adjustSize() {
      this.iconStyle.fontSize = `${DEFAULT_STYLE.iconFontSize * this.calculateSizeRatio()}rem`
      this.iconStyle.transform = `translate(${DEFAULT_STYLE.iconOffset *
        this.calculateSizeRatio()}rem, -${DEFAULT_STYLE.iconOffset * this.calculateSizeRatio()}rem)`
      this.numbersStyle.fontSize = `${DEFAULT_STYLE.numberFontSize * this.calculateSizeRatio()}rem`
      this.unitStyle.fontSize = `${DEFAULT_STYLE.unitFontSize * this.calculateSizeRatio()}rem`
      this.titleStyle.fontSize = `${DEFAULT_STYLE.titleFontSize * this.calculateSizeRatio()}rem`
    },

    calculateCurrentWidth() {
      return this.$el.offsetWidth
    },

    calculateSizeRatio() {
      return this.calculateCurrentWidth() / DEFAULT_STYLE.width
    }
  }
}
</script>
