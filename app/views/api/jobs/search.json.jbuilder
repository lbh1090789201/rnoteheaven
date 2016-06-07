json.success true
json.info "获取职位列表成功"
json.jobs do
  json.array!(@jobs) do |job|
    json.extract! job,
                  :id,
                  :name,
                  :location,
                  :job_type,
                  :job_desc,
                  :salary_range,
                  :needed_number
  end
end
