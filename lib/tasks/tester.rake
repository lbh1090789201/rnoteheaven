namespace :tester do
  desc "备份所有数据"
  task :excel => :environment do
    # Spreadsheet.client_encoding = "UTF-8"
    # workbook = Spreadsheet::ParseExcel.parse(params[:hospital].tempfile)
    puts File.new('tmp/云康bug.xls').size
    book = Spreadsheet.open('tmp/云康bug.xls')
    puts book.worksheets.length
    sheet1 = book.worksheet(0)
    # p sheet1.length
    sheet1.each do |row|
      row.each do |r|
        puts r
      end
      # break if row[0].nil? # if first cell empty
      # p row.join(',') # looks like it calls "to_s" on each cell's Value
    end
  end
end
