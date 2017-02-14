如何从一个模板工程生成一个工程

1.cp 一份本工程到新的工程
2.删除原项目中的./git（）文件
3.修改.rbriks/config中的app_name等的含有原项目名称改为现在名称
4.修改config目录下文件中（所有文件都找一遍）原项目名称为现在名称
5.Rakefile文件文件中原项目名称为现在名称
5.可以使用 find . -name "*.rb" -exec grep -i "oldname" {} \; -print命令找到所有rb文件中有原项目名称，逐个修改
6.清除原项目中tmp/下的所有文件

!!! please go through all the howtos before coding
