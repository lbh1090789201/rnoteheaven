json.success true
json.info "职位收藏成功"
json.favorite_job do
  json.extract! @favorite_job,
                  :id,
                  :job_id,
                :user_id,
                  :created_at
end
