## 通过token请求，回传字段，需增加
- Hospital 医院端
```
t.string :contact_person #负责人
t.string :contact_number #手机号码
t.float :lat #医院纬度
t.float :lng #医院经度
```

## 双选会图标链接
只需在GET请求上加 `to=fair`，如
```
http://yk.yundaioa.com/api/v1/connect_app?userId=289&token=dsafafasfasfs&to=fair
```

## 其他
1、需一个医院端帐号，用于测试
2、加上双选会后，麻烦再分享下  ios 与 android 客户端下载地址


## 医院用户注册/登录流程

1. 管理员添加医院
    ```
    http://yk.yundaioa.com/
    帐号: admin
    密码: 123456
    ```

2. 用户登录云康APP，登录成功后，发送请求
    ```
    请求类型: POST
    请求地址: http://yk.yundaioa.com/api/v1/connect_app/get_hospital
    请求数据(JSON): {"telephone": "18812341234"}
    ```

    - success
    ```
      {
        "success": true,
        "info": "获取医院信息成功！",
        "hospital": {
          "id": 1,
          "name": "深圳第一医院",
          "location": "广东省深圳市宝安区第二人民医院",
          "contact_person": "严锐"
        }
      }
    ```

    - fail
    ```
    {
      "success": false,
      "info": "非医院负责人。"
    }
    ```
3. 云康APP,设定用户为医院用户,并设置医才链接（token，userId）
4. 用户点击,医才端根据 token 向云康发出请求，需要返回：
```
# 多返回一个字段
telephone
```
5. 医才端根据信息创建并关联用户和医院，注册并登录
