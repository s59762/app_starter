const { environment } = require('@rails/webpacker')
const merge = require('webpack-merge')
const webpack = require('webpack')

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.set('Provide', new webpack.ProvidePlugin({
  Rails: 'rails-ujs',
  Turbolinks: 'turbolinks',
  jQuery: 'jquery',
  $: 'jquery'
}))

environment.loaders.set('import-glob', {
  test: /\.sass$/,
  use: 'import-glob-loader'
})

module.exports = environment
