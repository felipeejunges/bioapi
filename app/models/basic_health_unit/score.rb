# frozen_string_literal: true

class BasicHealthUnit::Score < ApplicationRecord
  validates_presence_of :size
  validates_presence_of :adaptation_for_seniors
  validates_presence_of :medical_equipment
  validates_presence_of :medicine

  has_one :basic_health_unit, inverse_of: :scores
end
