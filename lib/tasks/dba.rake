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
end
