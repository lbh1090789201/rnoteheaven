# 云康二次会议

## 模型修改
1. resume 添加字段 refresh_at //z
2. 应聘记录表，添加医院等冗余信息 //z
3. 修改谁看过我的简历，resume_viewers //z
4. 添加 block_hospitals //z

## 逻辑实现
1. home页面，search 搜索  ajax -> api/jobs_controller.rb/search
2. 应聘职位/医院详情，改为无跳转切换，底部改为 ajax:post 提交
3. 收藏 -> api/../create
4. 应聘 -> api/aplly_resume/create
5. 查看所有职位 jobs/ filter实现

## 页面修改
1. 简历基本信息按钮点击，-> 基本信息修改，去掉简历页面【编辑】按钮
2. 编辑工作界面，删除【撤销，新建】按钮

## 特别提醒
1. 测试优先，每个方法都需要有测试

## 新功能
1. 做个医院端的 dashboard
