const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const nodeModulesPath = path.resolve(__dirname, 'node_modules');

module.exports = {
  devtool: 'source-map',
  entry: {
    app: './web/static/js/app.js'
  },
  output: {
    path: path.resolve(__dirname, 'priv', 'static'),
    filename: 'js/[name].js'
  },
  plugins: [
    new CopyWebpackPlugin([
      {
        from: path.resolve(__dirname, 'web', 'static', 'assets'),
        to: path.resolve(__dirname, 'priv', 'static')
      }
    ]),
    new ExtractTextPlugin({ filename: 'css/[name].css', allChunks: true })
  ],
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [{ loader: 'css-loader', options: { sourceMap: true } }]
        })
      },
      {
        test: /\.(jpg|jpeg|gif|png)$/,
        exclude: [nodeModulesPath],
        loader: 'file-loader'
      },
      {
        test: /\.(woff2?|ttf|eot|svg)(\?[a-z0-9\=\.]+)?$/,
        exclude: [nodeModulesPath],
        loader: 'file-loader'
      }
    ]
  }
};
