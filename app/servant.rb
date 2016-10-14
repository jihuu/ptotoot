require 'db_dude'
require 'data_point'

class Servant
  def initialize
    puts "Servant init"
    @db_dude = DbDude.new
  end

  def create_and_add_data_point(origin_time, weight, data_class, source, type, extras)
    data_point = DataPoint.new(origin_time, weight, data_class, source, type, extras)
    add_data_point(data_point)
  end

  def add_data_point(data_point)
    @db_dude.store_data_point(data_point)
  end

  def get_data_points_by_time(earliest_time, latest_time)
    raise "not implemented"
  end

  def get_data_points_by_time_and_filter(earliest_time, latest_time, filter_column, filter_pass_criteria, group_by_column)
    results = @db_dude.get_data_points_by_time_and_filter(earliest_time, latest_time, filter_column, filter_pass_criteria, group_by_column)
    return results
  end

  def get_data_points
    raise "not implemented"
  end

end
