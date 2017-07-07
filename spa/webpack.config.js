const path = require('path');

module.exports = {
  entry: path.resolve(__dirname, './app.jsx'),
  output: {
    path: path.resolve(__dirname, '../assets/compiled'),
    filename: "spa.js"
  },
  module: {
    loaders: [{
      test: /\.(js|jsx)/,
      exclude: /node_modules/,
      loader: 'babel-loader',
      query: {
        presets: ['react', 'es2015']
      }
    }]
  }
};
