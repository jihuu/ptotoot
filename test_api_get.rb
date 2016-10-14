command = 'curl -X GET http://127.0.0.1:4567/report --data "start=2016-10-13T00:00:00Z&end=2016-10-15T00:00:00&filter_column=source&filter_pass_criteria=validator&group_by_column=class"'
result = `#{command}`
puts "result: #{result}"
