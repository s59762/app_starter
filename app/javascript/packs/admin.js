import "../src/admin/css/application.css.sass"
import 'bootstrap'
import 'admin-lte'
import Vue from 'vue/dist/vue.esm'

// booting up rails-ujs and Turbolinks
Rails.start()
Turbolinks.start()

// vms 用來放 Vue instances
let vms = []

// import all vue initializers
let vueInitializers = {}
let requireContextForvueInitializers = require.context('../src/admin/js/vue_initializers', false, /\.js$/)
requireContextForvueInitializers.keys().forEach(key => {
  let name = key.split('/').pop().split('.').shift()
  vueInitializers[name] = requireContextForvueInitializers(key).default
})

// initializing Vue instances that will be used in current views when turbolinks loaded
document.addEventListener('turbolinks:load', () => {
  let templates = document.querySelectorAll('[data-vue]')

  for (let element of templates) {
    let vm = new Vue(
      Object.assign(vueInitializers[element.dataset.vue], { el: element })
    )
    vms.push(vm)
    // console.log("vm initialized")
  }
})

// destroy all Vue instances in vms when user visit another page
document.addEventListener('turbolinks:visit', () => {
  for (let vm of vms) {
    vm.$destroy()
    // console.log("vm destroyed")
  }
  vms = []
})
