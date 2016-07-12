class EventLog < ActiveRecord::Base

  # 用作生成日志
    def self.create_log user_id, show_name, table, obj_id, object_name, action
      data = {
        user_id: user_id,
        show_name: show_name,
        table: table,
        obj_id: obj_id,
        object_name: object_name,
        action: action
      }

      EventLog.create!(data)
    end
end
