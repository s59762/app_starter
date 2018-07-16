const {
  environment
} = require('@rails/webpacker')
const webpack = require('webpack')
const vue = require('./loaders/vue')

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    Rails: 'rails-ujs',
    Turbolinks: 'turbolinks',
    jQuery: 'jquery',
    $: 'jquery',
    I18n: 'i18n-js',
    // 'window.Quill': 'quill/dist/quill.js',
    // Quill: 'quill/dist/quill.js'
  })
)

// Ignore moment js locale files
environment.plugins.append(
  'Ignore',
  new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/)
)

environment.loaders.append('vue', vue)

environment.loaders.append('import-glob', {
  test: /\.sass$/,
  use: 'import-glob-loader'
})

environment.loaders.append('pug', {
  test: /\.pug$/,
  use: 'pug-loader'
})

module.exports = environment
