let webpack = require("webpack");
let path = require("path");
let CURRENT_PATH = path.resolve(__dirname); // 获取到当前目录
let ROOT_PATH = path.join(__dirname, '../'); // 项目根目录
let devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';

/******************webpack用于模块管理，项目打包**************************/
/*********webpack or gulp压缩/合并文件，暂未知哪个更好********************/

let config = {
  entry: {
    // 页面入口文件配置
    index: [
      CURRENT_PATH + '/src/index.js'
    ],
    // vendors: [
    //   ROOT_PATH + "vendor/assets/javascripts/jquery-1.8.3.min",
    //   ROOT_PATH + "vendor/assets/javascripts/bootstrap.min"
    // ] //用于合并文件,只能合并npm安装的库／插件，否则会受到加载器的影响，或者可配置exclude/include,未试过
  },

  module: {
    //　加载器配置
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "jsx-loader?harmony"
      },
      {
        test: /\.js|jsx$/,
        exclude: /node_modules/,
        loader: 'babel-loader?presets[]=es2015,presets[]=react,presets[]=stage-0'
      }
    ]
  },
  // 定义访问模块的路径和扩展名
  resolve: {
    extensions: ['', '.js', '.json', '.scss', '.jsx'],
    alias: {
      react: path.resolve(__dirname, './node_modules/react'),
      "react-dom": path.resolve(__dirname, './node_modules/react-dom')
    }
  }
};

if(devBuild) {
  /*配置开发环境的配置*/
    // 入口文件输出配置
    config.output = {
      // path: ROOT_PATH + "app/assets/javascripts",
      filename: "bundle-[name].js"
    };
    config.plugins = [
      new webpack.HotModuleReplacementPlugin(),
      new webpack.NoErrorsPlugin(),
      /*******运行gulp时，DefinePlugin直接报错，未找出原因*****/
      // new webpack.DefinePlugin({
      //   'process.env.NODE_ENV': JSON.stringify("development")
      // })
      // 把一个全局变量插入到所有的代码中
      //   new webpack.ProvidePlugin({
      //    $: "jquery",
      //    jQuery: "jquery",
      //    "window.jQuery": "jquery"
      //  })
    ];
    config.devtool = 'eval-source-map';
}else{
  config.output = {
    // path: ROOT_PATH + "app/assets/javascripts",
    filename: "bundle-[name].[hash].js"
  };

  config.plugins = [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify("production")
    }),
    /*合并第三方插件或库*/
    //把入口文件里面的数组打包成vendors.js
    // new webpack.optimize.CommonsChunkPlugin({
    //   name: 'vendors',
    //   filename: 'bundle-vendors.js'
    // }),
    /*合并第三方插件或库*/

    /*压缩优化代码开始  可以关掉*/
    new webpack.optimize.UglifyJsPlugin({
      minimize: true, //压缩
      compress: {
          warnings: false
      },
     except: ['$super', '$', 'exports', 'require']    //排除关键字
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
    /*压缩优化代码结束*/
  ];
}

module.exports = config;
