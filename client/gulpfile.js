var gulp = require("gulp");
var webpack = require("gulp-webpack");
var webpackConfig = require('./webpack.config');

/*******************gulp用于构建前端自动化***********************/
// 定义任务
gulp.task("default", ["bundle", "watch"]);

// webpack打包
gulp.task("bundle", function() {
  return gulp.src("src/*.js")
             .pipe(webpack(webpackConfig))
             .pipe(gulp.dest("../app/assets/javascripts/src"));
});

// 监听文件是否有改动，实现刷新页面
gulp.task("watch", function() {

  gulp.watch(["src/*.js", "src/**/*.jsx"], function(event) {
    if(event.type == "changed") {
      return gulp.src("src/*.js")
                 .pipe(webpack(webpackConfig))
                 .pipe(gulp.dest("../app/assets/javascripts/src"));
    }
  });
  // return gulp.src("src/*.js")
  //            .pipe(webpack(getConfig({watch: true})))
  //            .pipe(gulp.dest("../app/assets/javascripts/src")); //这会输出不知什么玩意的js文件
});

/********************************************/
function getConfig(opts) {
  var config = {
    module: {
      loaders: [
        {test: /\.js|jsx$/, loader: "babel-loader?presets[]=es2015,presets[]=react,presets[]=stage-0"}
      ]
    }
  };

  if(!opts) {
    return config;
  }
  for(var key in opts) {
    config[key] = opts[key];
  }
  return config;
}
