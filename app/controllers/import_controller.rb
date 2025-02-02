class ImportController < ApplicationController
    def csv_import
        file_path = params[:file].path
        CsvImporter.import(file_path)
        render json: { message: 'Import successful' }, status: :ok
    
    rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
end