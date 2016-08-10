## 集成到APP后流程
1、目前只需将 云康APP 【云康医聘】/【云康医才】的链接设置为如下格式：
     http://yk.yundaioa.com/api/v1/connect_app?userId=289&token=dsafafasfasfs&lat=39.983424&lng=116.322987


2、其中，userId：用户ID，token：由云康APP生成

3、点击后，通过对 userId 较检用户是否已注册。已注册则直接登陆；未注册则通过 token 获取用户信息，注册并登陆。


## 目前疑问
访问链接为 get 方式，并携带 userId，是否存在安全隐患？

不知最终集成到 APP 的情况，目前来讲，只要拿到 用户ID ，就可访问用户信息。

如果只带 Token ，每次用 Token获取数据，安全性会提交。只是每次访问会多一次获取用户信的请求。


## 云康登陆方案流程(未集成前)

1. 点击按钮（医院API，医生API） `/users/sign_in`

2. AJAX方式POST到 `/api/v1/connect_app/login_app`
    ```
    # 应聘者提交如下字段
    {
          session: "28920160606162521",
          seq: 0,
          userId: 289,
          target: 'candidate'
        }

    # 招聘者提交如下字段
    recruit = {
          session: "28820160629153437",
          seq: 0,
          userId: 288,
          target: 'recruit'
        }
    ```

3. 由 `api/connect_app_controller.rb` login_app 方法处理
    ```
    # post 到 http://120.97.224.253:9014/HealthComm/modelToken/getToken 获取 Token

    # 用获取到的 Token post 到 http://119.97.224.253:9014/HealthComm/modelToken/accreditLogin 获取用户数据

    # 用获得的 userid 与 本地数据库 User.user_number 比较
    # 相同则 获取用户并登陆，不同交由 sign_up_copper 或sign_up_gold注册新用户
    ```
