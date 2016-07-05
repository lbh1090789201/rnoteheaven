## 云康登陆方案流程

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

## APP
1. http://yk.yundaioa.com/api/v1/connect_app?userId=1&token=dsafafasfasfs

2. get /api/v1/connect_app
