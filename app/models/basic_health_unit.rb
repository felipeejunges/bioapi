# frozen_string_literal: true

class BasicHealthUnit < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :city
  validates_presence_of :cnes
  belongs_to :geocode, inverse_of: :basic_health_unit,
                       class_name: 'BasicHealthUnit::Geocode'
  belongs_to :scores, inverse_of: :basic_health_unit,
                      class_name: 'BasicHealthUnit::Score'
end
