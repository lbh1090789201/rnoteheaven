# README

- 前端配置均在client文件夹内
- webpack -- gulp -- react
- 运行项目(需搭配好ruby/node/webpack环境)
```
根目录: bundle install & rake db:create db:migrate db:seed & rails s -b 0.0.0.0
client目录下: npm run dev
```
- 该项目中前端自动化及模块化目前只是最简单的实现方式，简化及更多文件合并/压缩还有待提高

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


app

config　：配置

db :数据库

spec　：测试


utils:工具文件夹

vendor：gem加载文件夹


怎么建立模型？
rails g model ModelName

rails g controller an_namesController

删除模型
rails d model ModelName

rails g controller an_namesController


编译运行
rails s 只能自己本地访问
rails s -b 0.0.0.0 默认端口3000,局域网可访问
rails s -b 0.0.0.0 -p 端口　可指定端口

局部测试方法
rails c
