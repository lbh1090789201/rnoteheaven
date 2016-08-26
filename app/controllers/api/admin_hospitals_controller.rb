class Api::AdminHospitalsController < ApplicationController
    before_action :require_hospitals_manager!
    protect_from_forgery :except => [:update]

    # def create
    #   p "2222222222"
    #   puts params[:hospital].to_json.to_s
    #   p"11111111111111"
    # end
    #
    # private
    #
    # def save_import
    # uploader = ExcelUploader.new
    # uploader.store!(params[:hospital])
    # book = Spreadsheet.open "#{uploader.store_path}"
    # sheet1 = book.worksheet 0
    # end
end
