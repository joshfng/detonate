const { environment } = require("@rails/webpacker");
// eslint-disable-next-line import/no-extraneous-dependencies
const webpack = require("webpack");

environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"],
  })
);

module.exports = environment;
