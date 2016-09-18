namespace :db do
  desc "备份所有数据"
  task :backup_all_data => :environment do
    Rake::Task['db:dump'].invoke
  end

  desc "备份所有应用数据"
  task :backup_app_data => :environment do
    system("mkdir -p db/backup/"+Date.today.strftime("%Y-%m-%d"))
    $app_models.each_with_index do |model, i|
      ENV["TABLE_NAME"] = model
      # rake db:dump会创建新的进程，导致无法返回，因此invoke/reenable无法工作
      # Rake::Task['db:dump'].reenable if i != 0
      #Rake::Task['db:testtt'].invoke
      filename = "db/backup/" + Date.today.strftime("%Y-%m-%d") +
          "/" + model + ".sql.gz"
      system("rake db:dump TABLE_NAME=#{model} | gzip >#{filename}")
    end
  end

  desc "恢复所有应用数据，参数：2015-09-10"
  task :restore_app_data, [:date_arg] => :environment do |t, args|
    #puts args.to_s
    db_date = args[:date_arg]
    $app_models.each_with_index do |model, i|
      ENV["TABLE_NAME"] = model
      filename = "db/backup/" + db_date.to_s +
          "/" + model + ".sql.gz"
      system("cat #{filename} | gunzip | rake db:restore ")
    end
  end

  desc "excel初始化数据"
  task :data_from_excel => :environment do
    # str = File.read('jobs.xlsx')

      file = "#{Rails.root}/jobs.xls"
      data = Spreadsheet.open file
      sheet1 = data.worksheet 0
      sheet1.each do |row|
        hospital = Hospital.find_by name: row[11]
        row[13].to_s == "是" ? is_top = true : is_top = false

        if hospital
          job = Job.new({
            name: row[1].to_s,
            job_desc: row[2].to_s,
            job_demand: row[3].to_s,
            needed_number: row[4].to_i,
            degree_demand: row[5].to_s,
            experience: row[6].to_s,
            recruit_type: row[7].to_s,
            region: row[8].to_s,
            salary_range: row[9].to_s,
            location: row[10].to_s,
            duration: row[12].to_i,
            is_top: is_top,
            status: "release",
            submit_at: Time.now,
            operate_at: Time.now,
            end_at: Time.now + (row[12].to_i).days,
            release_at: Time.now,
            job_type: row[14],
            hospital_id: hospital.id
          })

          job.save!
        else
          p "不存在该公司--" + row[11].to_s
        end
      end
  end
end
