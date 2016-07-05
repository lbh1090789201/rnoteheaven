1.  接口已经开发完成，
      应聘者信息：
           "uaid": 289,
           "gender": "男",
           "realName": "",
           "telephone": "15072417588".
         ①所在城市没有给定是机遇一下考虑：
                   用户设定的所在城市可能和应聘的单位的地方不一样，例如：小A的微信位置设定的为北京，但是他可能应聘的单位在武汉，所以需要当前定位。
         ②邮箱和生日由于在app注册的时候不是必须项目，暂且没有这两项的信息。


      招聘者信息：
         "entid":1,
         "entname":"东莞市莞城人民医院"
         "entaddress":"广东省东莞市塘厦镇环市西路35号"
    以上信息，如有需要增加，再联络

 2.  招聘和应聘的身份target已经定义，应聘：candidate  招聘：recruit。（不过，现在获取用户信息的时候已经不需要target了，上次和你通话的时候沟通过）

 3.  之前文档里给定了一个288用户的账号，该账号是招聘者身份（recruit），在按照文档中获取token的时候需要把target改为recruit（文档中记载的是recruitment）。
      现在给你们弄了一个招聘身份的账号，id为289（candidate），target为candidate，


      在招聘者获取token的时候记得把target改为candidate，该用户的session为  28920160606162521


## test
"lgParam":{"session":"28820160622100520","seq":0},
userid: 288,
target: recruit

## 医院端获得数据
{"entid":1,"entname":"东莞市莞城人民医院","entaddress":"广东省东莞市塘厦镇环市西路35号"}

{"utf8"=>"✓", "authenticity_token"=>"YWF298Hau6uRVXlDXgKxW1cb9kbWjbh8V6E85UKFSFGuiysc6cRvLOcZSjLG7BR1WT28z3gdkubCX
FqEddRtEw==", "user"=>{"username"=>"boss", "password"=>"[FILTERED]"}, "commit"=>"登陆"}


## 需求
用户邮箱
医院邮箱
医院 经纬度，我们新建时提供

## 笔记
root_url 获取当前主机地址和端口
require 'rest-client' # 模拟客户端gem
SecureRandom.uuid 随机不重复
JSON.parse(@res)["responseCode"]
