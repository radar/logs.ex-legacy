var webpack = require('webpack');
var path = require('path');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

var BUILD_DIR = path.resolve(__dirname, 'priv/static');
var APP_DIR = path.resolve(__dirname, 'web/static');


var config = {
  entry: APP_DIR + '/js/app.js',
  output: {
    path: BUILD_DIR,
    filename: 'js/app.js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style-loader!css-loader" }
    ]
  },
  plugins: [
    new ExtractTextPlugin("[name].css")
  ]
};

module.exports = config;
