class PersonSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :species, :gender, :weapon, :vehicle
  has_many: :locations
  has_many: :affiliations
end
