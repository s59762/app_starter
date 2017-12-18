<template lang="pug">
  div
    h2 {{message}}

    h3 Vuex 測試

    div
      label Counter
      p {{counter}}

    button(@click="increment") +1
    button(@click="decrement") -1
</template>

<script>
export default {
  data: () => ({
    message: 'hello from component'
  }),
  computed: {
    counter() {
      return this.$store.state.count
    }
  },
  methods: {
    increment() {
      this.$store.commit('increment')
    },
    decrement() {
      this.$store.commit('decrement')
    }
  }
}
</script>

<style scoped>
p {
  color: #555;
  font-size: 1.5em;
}
</style>
