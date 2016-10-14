require 'mysql'
require 'data_point'

class DbDude
  def initialize
    puts "DbDude instance init"
    db_params = get_db_params
    connect(db_params)
    create_data_points_table rescue nil
  end

  def get_db_params
    host = ENV['DB_HOST']
    user = ENV['DB_USER']
    password = ENV['DB_PASSWORD']
    database = ENV['DB_DATABASE_NAME']
    {:host => host, :user => user, :password => password, :database => database}
  end

  def connect(params)
    puts "Connecting to db"
    @db_client = Mysql::new(params[:host], params[:user], params[:password], params[:database])
  end

  def store_data_point(data_point)
    store_str = "INSERT INTO data_points VALUES(#{data_point.origin_created_time}, " +
                "#{data_point.created_at}, #{data_point.weight}, #{data_point.data_class}, " +
                " #{data_point.source}, #{data_point.type}, #{data_point.extras}, NULL)"
    execute_query(store_str)
  end

  def create_data_points_table
    create_str = 'CREATE TABLE data_points(origin_created_time TIMESTAMP, created_at TIMESTAMP NOT NULL, weight float, class varchar(255) NOT NULL, source VARCHAR(255) NOT NULL, type VARCHAR(255) NOT NULL, extras TEXT NOT NULL, id SERIAL)'
    execute_query(create_str)
  end

  def get_data_points_by_time_and_filter(window_start, window_end, filter_column, filter_pass_criteria, group_by_column)
    query_str = nil
    if filter_column != nil
      query_str = "SELECT #{group_by_column}, #{filter_column}, count(*) AS total FROM data_points WHERE origin_created_time >= '#{window_start}' AND origin_created_time < '#{window_end}' AND #{filter_column} LIKE '%#{filter_pass_criteria}%' GROUP BY #{group_by_column} ORDER BY total DESC"
    else
      query_str = "SELECT #{group_by_column}, count(*) AS total FROM data_points WHERE origin_created_time >= '#{window_start}' AND origin_created_time < '#{window_end}' GROUP BY #{group_by_column} ORDER BY total DESC"
    end
    execute_query(query_str)
  end

  def execute_query(sanitized_query_str)
    rs = @db_client.query(sanitized_query_str)
    result_array = []
    rs.each_hash do |row|
      result_array.push(row)
    end
    result_array
  end

end
