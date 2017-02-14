require 'net/http'
module UsersHelper
  #生成随机数
  def generate_user_number_code
    array = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

    code = ''
    (1..6).each do
      code += array[rand(62)]
    end

    user = User.find_by(user_number: code)

    if user
      return generate_user_number_code
    else
      return code
    end
  end

  def generate_user_email_code
    array = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    code = ''
    (1..10).each do
      code += array[rand(26)]
    end

    code = code + '@rnoteheaven.com'
    user = User.find_by(email: code)

    if user
      return generate_user_email_code
    else
      return code
    end
  end

  def test_generate_user_openid
    array = ['-','_','0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    code = ''
    (1..28).each do
      code += array[rand(64)]
    end

    user = User.find_by(wechat_openid: code)

    if user
      return test_generate_user_openid
    else
      return code
    end
  end

  def generate_user_cellphone_code
    array = ['0','1','2','3','4','5','6','7','8','9']
    code = ''
    (1..9).each do
      code += array[rand(10)]
    end

    code = '00' + code
    user = User.find_by(cellphone: code)

    if user
      return generate_user_cellphone_code
    else
      return code
    end
  end

  def download_avater_from_net(file_url)
    Net::HTTP.start("wx.qlogo.cn") { |http|
      resp = http.get("/mmopen/lA4wAbiawYzSzCiclWlu0ZqmVHEKOnNAOSxPwQSWH8lR5AicibwBaZvgLxmYbYwrTrUyJicOQz1NOPg6Wug1icuzWHCUJ5jreX6ENK/0")
      open("D:/test.png", "wb") { |file|
        file.write(resp.body)
      }
    }
    puts "OK"

  end

end
