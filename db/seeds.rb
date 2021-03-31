# frozen_string_literal: true

require 'csv'

def load_seeds
  load_ubs
end

def load_ubs
  file_name = 'ubs.csv'
  csv_rows = load_seed(file_name)
  csv_rows.each_with_index do |row, index|
    ActiveRecord::Base.transaction do
      basic_health_unit = BasicHealthUnit.find_or_create_by(
        name: row['nom_estab'],
        city: row['dsc_cidade'],
        cnes: row['cod_cnes']
      )
      basic_health_unit.address = row['dsc_endereco']
      basic_health_unit.phone   = row['dsc_telefone']

      geocode = BasicHealthUnit::Geocode.find_or_create_by(
        lat:  row['vlr_latitude'],
        long: row['vlr_longitude']
      )

      unless basic_health_unit.scores_id.present?
        scores = BasicHealthUnit::Score.new(
          size:                   convert_score_to_integer(row['dsc_estrut_fisic_ambiencia']),
          adaptation_for_seniors: convert_score_to_integer(row['dsc_adap_defic_fisic_idosos']),
          medical_equipment:      convert_score_to_integer(row['dsc_equipamentos']),
          medicine:               convert_score_to_integer(row['dsc_medicamentos'])
        )
      end

      geocode.save
      scores.save

      basic_health_unit.geocode_id = geocode.id
      basic_health_unit.scores_id  = scores.id

      saved = basic_health_unit.save

      print "\r* #{file_name} #{index} of #{csv_rows.length - 1} | saved: #{saved} | b: #{basic_health_unit.id} | s: #{scores.id} | g: #{geocode.id}"

      saved
    end
  end
end

def convert_score_to_integer(var)
  case var
  when 'Desempenho mediano ou  um pouco abaixo da média'
    1
  when 'Desempenho acima da média'
    2
  when 'Desempenho muito acima da média'
    3
  end
end

def load_seed(file_name)
  print "\r* Loading #{file_name}"
  csv_text = File.read(Rails.root.join('db', 'seeds', file_name))
  CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
end

load_seeds

$stdout.flush
