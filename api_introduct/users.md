# 接口说明：

# 获取当前用户的详细信息
访问: https://website/users/ + 当前用户id
response:

@user = {
    "user"=>{
        "id"=>1,
        "start_work_at"=>nil,
        "region"=>nil,
        "highest_degree"=>nil,
        "birthday"=>nil,
        "position"=>"前端工程师",
        "company"=>"某信息科技有限公司",
        "introduction"=>"本人从事前端工程师多年。我的性格偏于内向，为人坦率、热情、讲求原则；处事乐观、专心、细致、头脑清醒；富有责任心、乐于助人。",
        "achievement"=>"所向披靡",
        "cellphone"=>"13888888778",
        "avatar"=>{
            "url"=>nil,
            : square=>{
                "url"=>nil
            }
        },
        "show_name"=>"test",
        "user_email"=>nil,
        "provider"=>"email",
        "uid"=>"test@example.com",
        "username"=>"test",
        "email"=>"test@example.com",
        "locked"=>false,
        "slug"=>"username",
        "sex"=>"男",
        "user_number"=>289,
        "user_type"=>"copper",
        "longitude"=>nil,
        "latitude"=>nil,
        "is_top"=>false,
        "created_at"=>Sun,
        13Nov201618: 59: 44CST+08: 00,
        "updated_at"=>Mon,
        21Nov201620: 16: 09CST+08: 00
    },
    "avatar"=>"avator.png",
    "art_amount"=>32,
    "recom_amount"=>29,
    "com_amount"=>29,
    "favorite_amount"=>16,
    "brecom_amount"=>28,
    "bfavorite_amount"=>16,
    "bcom_amount"=>28
}


# 更新用户头像
call: https://website/users/ + 当前用户id
method: patch 或者　put
require:
* with parameters
{
  avatar: asda,
  text: asdd,
  id: 11
}
response(data):

成功返回：
{
  success: true,
  info: "更改头像成功！",
  avatar: "avator.png"
}, status: 200
失败返回:
{
  success: false,
  info: "更改头像失败！",
}, status: 403

# 编辑页面
访问: https://website/users/ + 当前用户id +/edit
@user = {
    "id"=>1,
    "start_work_at"=>nil,
    "region"=>nil,
    "highest_degree"=>nil,
    "birthday"=>nil,
    "position"=>"前端工程师",
    "company"=>"某信息科技有限公司",
    "introduction"=>"本人从事前端工程师多年。我的性格偏于内向，为人坦率、热情、讲求原则；处事乐观、专心、细致、头脑清醒；富有责任心、乐于助人。",
    "achievement"=>"所向披靡",
    "cellphone"=>"13888888778",
    "avatar"=>{
        "url"=>nil,
        : square=>{
            "url"=>nil
        }
    },
    "show_name"=>"test",
    "user_email"=>nil,
    "provider"=>"email",
    "uid"=>"test@example.com",
    "username"=>"test",
    "email"=>"test@example.com",
    "locked"=>false,
    "slug"=>"username",
    "sex"=>"男",
    "user_number"=>289,
    "user_type"=>"copper",
    "longitude"=>nil,
    "latitude"=>nil,
    "is_top"=>false,
    "created_at"=>Sun,
    13Nov201618: 59: 44CST+08: 00,
    "updated_at"=>Mon,
    21Nov201620: 16: 09CST+08: 00
}


@avatar = "avator.png"
