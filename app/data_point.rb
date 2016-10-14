class DataPoint
  attr_accessor :origin_created_time, :created_at, :weight, :data_class,
                :source, :type, :extras

  def initialize(origin_created_time, weight, data_class, source, type, extras)
    # todo: sanitize/validate values
    @created_at = "'#{Time.now.utc.iso8601}'"
    @origin_created_time = "'#{origin_created_time}'"
    @weight = "#{weight}"
    @data_class = "'#{data_class}'"
    @source = "'#{source}'"
    @type = "'#{type}'"
    @extras = "'#{extras}'"
  end

  def self.do_stuff
    puts "doing stuff inna datapoint"
  end
end
