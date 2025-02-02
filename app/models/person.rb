class Person < ApplicationRecord
    has_and_belongs_to_many :locations
    has_and_belongs_to_many :affiliations
    validates :first_name, :species, :gender, presence: true
end
