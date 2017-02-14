# Generated with RailsBricks
# Initial seed file to use with Devise User Model
#
user = User.create!(
    username: "test",
    show_name: "test",
    password: "123456",
    email: "test@example.com",
    cellphone: "13888888778",
    position: "前端工程师",
    company: "某信息科技有限公司",
    achievement: "所向披靡",
    introduction: "本人从事前端工程师多年。我的性格偏于内向，为人坦率、热情、讲求原则；处事乐观、专心、细致、头脑清醒；富有责任心、乐于助人。",
    sex: "男",
    user_type: "copper",
    user_number: 289
)

# user.add_role :admin

# aa = User.create!(
#     username: "admin",
#     show_name: "admin",
#     password: "12345678",
#     email: "admin2@example.com",
#     cellphone: "13833332222",
#     user_type: "admin",
#     sex: "女"
# )
# aa.add_role :admin
#
# u = User.create!(
#     username: "boss",
#     show_name: "boss",
#     password: "12345678",
#     email: "employer@example.com",
#     cellphone: "13811112222",
#     sex: "女",
#     user_type: "gold",
#     user_number: 1
# )
# u.add_role :gold
#
# u = User.create!(
#     username: "boss2",
#     show_name: "boss2",
#     password: "12345678",
#     email: "employer2@example.com",
#     cellphone: "138111122222",
#     sex: "女",
#     user_type: "gold",
#     user_number: 1
# )
# u.add_role :gold
#
# u = User.create!(
#     username: "boss3",
#     show_name: "boss3",
#     password: "12345678",
#     email: "employer3@example.com",
#     cellphone: "138111122223",
#     sex: "女",
#     user_type: "gold",
#     user_number: 1
# )
# u.add_role :gold

title = ["受贿为满足家人 落马书记的“全家腐”害人害己", '"首善"or"首骗" 陈光标事件必须走出舆论漩涡', "郭德纲和曹云金互撕 公开辩论不是说相声",
        "6平方鸽笼房被一抢而空 颇具魔幻现实主义", '一天600多个骚扰电话 给卖家差评如摸老虎屁股', '“少女弑母”背后该整治网戒机构了',
        "案外案！查查出生证买卖背后有多少儿童拐卖", '媒体：“假艳照”揪出几多真问题？', '把实习生“卖”进工厂算哪门子教育',
        '公务员专用出租车 这是把公职人员架“火上烤”', "朱莉和皮特 归根结底是自己粉碎了爱情", "人没了支付宝还在 脑洞大开让网友坐不住了",
        "网友快评：不帮养孩子叫什么社会抚养费？", '优步“幽灵车”出没 不仅是技术问题', "电子证据新规出台，朋友圈能随便发牢骚吗", "受贿为满足家人 落马书记的“全家腐”害人害己",
        '"首善"or"首骗" 陈光标事件必须走出舆论漩涡', "郭德纲和曹云金互撕 公开辩论不是说相声", "6平方鸽笼房被一抢而空 颇具魔幻现实主义",
        '一天600多个骚扰电话 给卖家差评如摸老虎屁股', '“少女弑母”背后该整治网戒机构了', "案外案！查查出生证买卖背后有多少儿童拐卖",
        '媒体：“假艳照”揪出几多真问题？', '把实习生“卖”进工厂算哪门子教育', '公务员专用出租车 这是把公职人员架“火上烤”',
        "朱莉和皮特 归根结底是自己粉碎了爱情", "人没了支付宝还在 脑洞大开让网友坐不住了",
        "网友快评：不帮养孩子叫什么社会抚养费？", '优步“幽灵车”出没 不仅是技术问题', "电子证据新规出台，朋友圈能随便发牢骚吗"]

(0..28).each do |i|
  note = Note.new ({
    user_id: user.id,
    title: title[i],
    author: "某某人",
    amount: 123,
    content: '<p>“你有权保持沉默，但你所说的每一句话都将作为呈堂证供”，这是最常见的tvb剧台词之一，其依据源自刑诉法层面的公民沉默权。
              现在这句话的辐射范围，可能还要加上微信朋友圈——一个被7.6亿人正在使用的社交平台。日前，最高法、最高检、公安部日前联合发布
              《关于办理刑事案件收集提取和审查判断电子数据若干问题的规定》。按照该《规定》，自2016年10月1日起，朋友圈、微博等信息经查证
              属实可以作为定案证据，公检法机关有权依法定程序，向单位和个人调取涉案人员上述平台的信息。</p>
              <p>“朋友圈也不安全啊”，这是初一看到此新规的一般公众感觉，之所以这么说，是因为微信朋友圈相较于其他互联网信息平台而言有相对
              的封闭性——只有互加好友的人才能看到彼此朋友圈所发内容</p>
              <p>“朋友圈条款”所引发的公民表达焦虑，其关键在于，即便是于法有据的某些“权力扩张”，其具体行为能否真正受到法律程序的约束和限制？</p>'
    })
    note.save!
end

(1..16).each do |i|
  favorite_article = FavoriteArticle.new ({
    user_id: user.id,
    note_id: i,
    })
    favorite_article.save!
end

(0..28).each do |i|
  comment = Comment.new ({
    user_id: user.id,
    note_id: i,
    content: "这是评论内容"
    })
    comment.save!
end

(0..28).each do |i|
  recommend = Recommend.new ({
    user_id: user.id,
    note_id: i,
    recom_amount: i + 10
    })
    recommend.save!
end

# Galleies.create! (image_url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/users/testfile.JPG'))))
