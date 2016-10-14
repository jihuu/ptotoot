# Encoding: utf-8
require 'rubygems'
require 'bundler'

require 'sinatra'
require 'mysql'
require 'rack/conneg'
require 'json'

#Bundler.require

require 'time'
require 'servant'

configure do
  set :server, :puma
end


use(Rack::Conneg) { |conneg|
  conneg.set :accept_all_extensions, false
  conneg.set :fallback, :json
  conneg.provide([:json])
}

before do
  if negotiated?
    content_type negotiated_type
  end
end

get '/report/?' do
  servant = Servant.new
  window_start = Time.parse(params["start"]).iso8601
  window_end = Time.parse(params["end"]).iso8601
  filter_column = params["filter_column"]
  filter_pass_criteria = params["filter_pass_criteria"]
  group_by_column = params["group_by_column"]

  results_hash = servant.get_data_points_by_time_and_filter(window_start, window_end,
                                             filter_column, filter_pass_criteria,
                                             group_by_column)

  return [200, results_hash.to_json]
end

post '/data_points/?' do

  weight = params["weight"]
  data_point_class = params["class"]
  source = params["source"]
  type = params["type"]
  extras = params["extras"]
  origin_system_timestamp = params["timestamp"]
  secret = params["secret"]

  if source.nil? or source.empty?
    halt 400, {:message=>"source field cannot be empty"}.to_json
  end

  begin
    servant = Servant.new
    result = servant.create_and_add_data_point(origin_system_timestamp, weight, data_point_class, source, type, extras)
  rescue
    [500, {:message=>"Failed to save data point"}.to_json]
  end
  return [201, {:done => "Data point added"}.to_json]
end
