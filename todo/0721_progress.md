# 云康进展及需平台协助事项

## 一、进展
云康医才、医聘， iOS 、 Android、Admin 已完成一轮完整测试。

- Admin
  > 地址：http://yk.yundaioa.com/
    用户名：admin
    密码：123456

- 医院端
  > 1. 登陆 Admin -入住机构-新建机构
  > 2. 用 *机构手机号 登陆 【云康APP】，点击【云康医才】

- 医生端
  > 登陆【云康APP】，点击【云康医聘】

## 二、需平台协助
1. iOS 与 Android 需添加【双选会入口】
   > 例：http://yk.yundaioa.com/api/v1/connect_app?userId=289&token=dsafafasfasfs&to=fair


2.  iOS 与 Android  点击 `<a href="tel:13811112222">拨打电话</a>`
    > Android端，王瑶已回复下版本解决。iOS端，待回复。
3. Android端，刷新问题，已收到 王瑶 接口文档，下版本解决
4. Android端，点击更换头像，无法调出相册。页面代码如下：
    >`
 <input class="file optional" type="file" name="user[avatar]" id="user_avatar">
 `
