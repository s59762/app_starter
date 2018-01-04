const { environment } = require('@rails/webpacker')
const merge = require('webpack-merge')
const webpack = require('webpack')

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.set(
  'Provide',
  new webpack.ProvidePlugin({
    Rails: 'rails-ujs',
    Turbolinks: 'turbolinks',
    jQuery: 'jquery',
    $: 'jquery',
    I18n: 'i18n-js'
  })
)

environment.loaders.set('import-glob', {
  test: /\.sass$/,
  use: 'import-glob-loader'
})

environment.loaders.set('pug', {
  test: /\.pug$/,
  use: 'pug-loader'
})

module.exports = environment
