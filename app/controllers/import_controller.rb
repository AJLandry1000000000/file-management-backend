class ImportController < ApplicationController
    def csv_import
        file_path = params[:file].path
        # print("printing the file path now! \n")
        # print(file_path + "\n")
        CsvImporter.import(file_path)
        render json: { message: 'Import successful' }, status: :ok
    
    rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
end