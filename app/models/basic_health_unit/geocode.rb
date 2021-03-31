# frozen_string_literal: true

class BasicHealthUnit::Geocode < ApplicationRecord
  validates_presence_of :lat
  validates_presence_of :long

  acts_as_mappable default_units:   :kms,
                   default_formula: :sphere,
                   lat_column_name: :lat,
                   lng_column_name: :long

  has_one :basic_health_unit, inverse_of: :geocode

  # BasicHealthUnit::Geocode.within(10, origin: ['-23.515810', '-47.487940'])
end
