## Kaminari
[官网](https://github.com/amatsuda/kaminari/blob/master/README.rdoc)
用途：分页
主题：
 - [foundation](http://foundation.zurb.com/sites/docs/v/5.5.3/components/pagination.html)
 - [各种主题](https://github.com/amatsuda/kaminari_themes)
 - 目前使用`rails g kaminari:views bootstrap3`
用法：
 1. 在 controller ，例如：`@items = SettlementRecord.page(params[:page]).per(5)`
 2. 对应视图添加 `<%= paginate @items %>`
