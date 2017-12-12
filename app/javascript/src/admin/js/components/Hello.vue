<template>
  <div>
    <h2>{{ message }}</h2>

    <h3>Vuex 測試</h3>
    <div>
      <label for="">Counter</label>
      <p>{{ counter }}</p>
    </div>
    <button @click="increment">+1</button>
    <button @click="decrement">-1</button>
  </div>
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
