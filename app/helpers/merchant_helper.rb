# author: bobo
module MerchantHelper

  # 按名称和地址搜索商户
  def search_by_name_address(name, address, page)
    p name.to_s + '--------'
    datas = []
    unless name.nil? && address.nil?
      page = page ? page.to_i : 1
      merchants_res = Merchant.where("name LIKE ? AND address LIKE ?", "%#{name}%", "%#{address}%").paginate(page:page,per_page:10)
      merchants_res.each do |f|
        count = f.restaurants.length
        merchant_res = f.as_json
        merchant_res["count"] = count
        datas.push(merchant_res)
      end
    end
    return datas
  end

end
