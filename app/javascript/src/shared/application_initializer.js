import Vue from 'vue/dist/vue.esm'

/**
 * 啟動 Application
 *
 * @class ApplicationInitializer
 */
class ApplicationInitializer {
  constructor() {
    this.vms = []
    this.vueInitializers = {}

    this.start()
  }

  /**
   * 啟動
   */
  start() {
    // booting up rails-ujs and Turbolinks
    Rails.start()
    Turbolinks.start()

    this.requireVueInitializers()
    this.detectAndInitializingVueInstances();
    this.destroyVueInstancesWhenPageChange();
  }

  /**
   * 在 `turbolinks:load` 事件發生時，把 `vms` 中的所有 Vue instances 都移除
   */
  destroyVueInstancesWhenPageChange() {
    document.addEventListener('turbolinks:visit', () => {
      for (let vm of this.vms) {
        vm.$destroy();
      }
      this.vms = [];
    });
  }

  /**
   * 在 `turbolinks:load` 事件發生時，查詢頁面中有 `data-vue` 的所有元素，並建立 Vue instances，記錄到 `vms` 中
   */
  detectAndInitializingVueInstances() {
    document.addEventListener('turbolinks:load', () => {
      let templates = document.querySelectorAll('[data-vue]');
      for (let element of templates) {
        let vm = new Vue(Object.assign(this.vueInitializers[element.dataset.vue], { el: element }));
        this.vms.push(vm);
      }
    });
  }

  /**
   * 讀取 `../admin/js/vue_initializers` 中的所有檔案，以 Object 的形式記錄到 `vueInitializers` 中
   */
  requireVueInitializers() {
    let requireContextForvueInitializers = require.context('../admin/js/vue_initializers', false, /\.js$/);
    requireContextForvueInitializers.keys().forEach(key => {
      let name = key.split('/').pop().split('.').shift();
      this.vueInitializers[name] = requireContextForvueInitializers(key).default;
    });
  }
}

export default ApplicationInitializer
