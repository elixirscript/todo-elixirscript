const path = require('path');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  devtool: 'source-map',
  cache: true,
  entry: [ './web/static/js/app.js', './web/static/css/app.css' ],
  output: {
    path: path.join(__dirname, 'priv', 'static'),
    filename: 'js/app.js',
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        use: 'babel-loader',
      },
      {
        test: [ /\.css$/ ],
        loader: ExtractTextPlugin.extract({
          fallbackLoader: 'style-loader',
          loader: 'css-loader',
        }),
      },
    ],
  },
  plugins: [
    new CopyWebpackPlugin([ { from: './web/static/assets' } ]),
    new ExtractTextPlugin('css/app.css'),
  ],
};
