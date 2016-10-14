reps = ARGV[0]
if reps != nil
  reps = Integer(reps)
else
  reps = 1
end
classes = ["Very Specific Error 1", "Just A Warning", "Strange Warning", "Warning that is going to be bumped into error soon", "Business as usual", "Super duper error"]
sources = ["validator", "validator", "validator", "validator", "validator", "repercussator", "donglenator"]
for i in 1..reps
  event_class = classes.sample
  if event_class != "Warning that is going to be bumped into error soon"
    event_class = classes.sample
  end
  source = sources.sample
  puts "executing command, using event class #{event_class}"
  command = "curl -X POST http://127.0.0.1:4567/data_points -F 'timestamp=2016-10-13T20:48:58Z' -F 'weight=1.0' -F 'class=#{event_class}' -F 'source=#{source}' -F 'type=warning' -F 'extras=bii,baa,buu'"
  puts "command: #{command}"
  result = `#{command}`
end
