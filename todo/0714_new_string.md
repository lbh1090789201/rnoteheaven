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
