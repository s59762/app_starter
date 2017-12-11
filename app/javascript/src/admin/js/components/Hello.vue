<template>
  <div>
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: () => ({
    message: 'hello from component'
  })
}
</script>

<style scoped>
p {
  color: #888;
  font-size: 1.5em;
}
</style>
