class ResumeViewer < ActiveRecord::Base
  belongs_to :hospital
  
  def self.set_viewer hid, uid

    if ResumeViewer.where(hospital_id: hid, user_id: uid).blank?
      res = ResumeViewer.new(user_id: uid, hospital_id: hid, view_at: Time.now)

      if res.save
        return { json: {
          success: true,
          info: "查看记录已保存"
        }, status: 200 }
      else
        return { json: {
          success: false,
          info: "查看记录保存失败！"
        }, status: 403 }
      end
    else
      return { json: {
        success: true,
        info: "查看记录已存在"
      }, status: 200 }
    end

  end

end
