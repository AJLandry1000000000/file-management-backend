require 'csv'

class CsvImporter
    def self.import(file_path) 
        CSV.foreach(file_path, headers: true) do |row|
            next if row['Affiliations'].blank?

            name_parts = row['Name'].split(' ')
            first_name = sanitize_field(name_parts.first) if name_parts.any?
            last_name = name_parts[1..-1].map { |name| sanitize_field(name) }.join(' ') if name_parts.size > 1
            species = sanitize_field(row['Species'])
            gender = sanitize_gender(row['Gender'])
            weapon = sanitize_field(row['Weapon'])
            vehicle = sanitize_field(row['Vehicle'])
        
            # Ensure first_name, species, and gender are all present.     
            next if first_name.blank? || species.blank? || gender.blank?
      
            person = Person.create(
              first_name: first_name,
              last_name: last_name,
              species: species,
              gender: gender,
              weapon: weapon,
              vehicle: vehicle
            )

            locations = row['Location'].split(',').map(&:strip).map(&:titleize)
            locations.each do |location_name|
                location = Location.find_or_create_by(name: location_name)
                person.locations << location
            end

            affiliations = row['Affiliations'].split(',').map(&:strip).map(&:titleize)
            affiliations.each do |affiliation_name|
                affiliation = Affiliation.find_or_create_by(name: affiliation_name)
                person.affiliations << affiliation
            end 
        end
    end

    def self.sanitize_field(field)
        # Remove any characters that are not numbers, letters, spaces, commas, single quotes, or hyphens.
        # Strip trailing or leading spaces then capitalize the first letter of the field.
        field&.gsub(/[^0-9a-zA-Z\s,\'-]/, '')&.strip&.sub(/^\w/, &:upcase)
      end
    
      def self.sanitize_gender(gender)
        case gender&.downcase
        when 'male', 'm'
          'Male'
        when 'female', 'f'
          'Female'
        else
          sanitize_field(gender)
        end
    end
end