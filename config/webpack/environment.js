const { environment } = require('@rails/webpacker')

// jQueryとBootstapのJSを使えるように
const webpack = require('webpack')
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)
// JQueryとBootstrapのJSここまで

module.exports = environment
