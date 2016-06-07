json.success true
json.info "创建应聘纪录成功"
json.apply_record do
  json.extract! @apply_record,
                  :id,
                  :job_id,
                :user_id,
                  :created_at
end
