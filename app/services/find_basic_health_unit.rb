class FindBasicHealthUnit < ComposableOperations::Operation
  property :query,    converts: :to_s, required: true
  property :range,    converts: :to_i, default: 25
  property :page,     converts: :to_i, default: 1
  property :per_page, converts: :to_i

  def execute
    find
    serialize
  end

  def find
    query_splitted    = query.split(',')
    lat               = query_splitted[0].to_d
    long              = query_splitted[1].to_d

    geocode_ids = BasicHealthUnit::Geocode
      .select(:id)
      .within(range, origin: [lat, long])
      .pluck(:id)

    @total_entries = geocode_ids.length

    @per_page = per_page
    @page     = page

    @per_page = @total_entries unless @per_page.present?

    @basic_health_units = BasicHealthUnit
      .where(geocode_id: geocode_ids)
      .includes(:geocode, :scores)

    @basic_health_units = @basic_health_units
      .page(@page)
      .per(@per_page)
  end

  def serialize
    entries = @basic_health_units.map do |buh|
      {
        id:      buh.id,
        name:    buh.name,
        address: buh.address,
        city:    buh.city,
        phone:   buh.phone,
        geocode: {
          lat:  buh.geocode.lat,
          long: buh.geocode.long,
        },
        scores:  {
          size:                   buh.scores.size,
          adaptation_for_seniors: buh.scores.adaptation_for_seniors,
          medical_equipment:      buh.scores.medical_equipment,
          medicine:               buh.scores.medicine,
        },
      }
    end

    # f = FindBasicHealthUnit.new(query: '-23.515810,-47.487940', range: 10)

    {
      current_page:  @page,
      per_page:      @per_page,
      total_entries: @total_entries,
      entries:       entries,
    }
  end
end
