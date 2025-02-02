class AffiliationSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :people
end
