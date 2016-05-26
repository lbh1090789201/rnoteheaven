# README

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



