# ptotoot
Ptotoot [toe-TOOT] is an ultra-simple microservice for putting things on top of
other things. A REST API offers functionality to store categorized data points
in to a database, and to query different things from the DB.

# Warning
Prototype. Does not sanitize inputs etc. Used only for testing things, for now.

# How to run the service
In order to run the service, use docker-compose (first build, then up).
This brings up the database and the main service. The DB init will take some
time on the first run (when db is empty).

Two environment variables need to be defined before running docker-compose:

   MYSQL_ROOT_PASSWORD is the root password of the database (it will be set
   from this variable, when starting MariaDB for the first time)

   DATABASE_VOLUME_DIRECTORY is the directory on host machine which will
   contain the actual MariaDB database. It will be mapped as a volume
   on the MariaDB docker container.

To make things nicer, two scripts are provided for running/stopping the service:
run and stop.

# How to use the service
After docker-compose has brought up both the database and the main service,
the basic functionality can be tested using cURL.

Posting a data point (example):

  curl -X POST http://127.0.0.1:4567/data_points -F 'timestamp=2016-10-13T20:48:58Z' -F 'weight=1.0' -F 'class=warning_class_1' -F 'source=some_source' -F 'type=warning' -F 'extras=foo,bar'

A successful resource save operation yields HTTP code 201.

Getting a filtered, time-limited report of data points:

  curl -X GET http://127.0.0.1:4567/report --data "start=2016-10-13T00:00:00Z&end=2016-10-15T00:00:00&filter_column=source&filter_pass_criteria=validator&group_by_column=class"

A successful report fetch operation yields a JSON object, which lists the matching result counts by group_by_column.
