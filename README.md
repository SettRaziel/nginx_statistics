# Nginx Statistics
<a href="https://codeclimate.com/github/SettRaziel/nginx_statistics"><img src="https://codeclimate.com/github/SettRaziel/nginx_statistics/badges/gpa.svg" /></a>

Ruby program to evaluate the log files of nginx. At the moment the basic script
shows the top 10 entries of the given entry attribute. These attributs are the
timestamp of the entry, the source ip, the http status and the http request.

## Usage & Help
```
script usage: ruby <script> <criteria> <filename>
help usage :  ruby <script> (-h | --help)

nginx_statistic help:
 -h, --help     show help text
 -v, --version  prints the current version of the project
Available index criteria:
--request       create index based on the http request
--status        create index based on the http status (default)
--source        create index based on the source address
--timestamp     create index based on the timestamp
```

## Documentation
Documentation is written in yard and can be created by running the shell-script
`create_yard.sh`. Yard needs to be installed on the system in order to do that.
The documentation can also be found online [here](https://bheld.eu/doc/nginxstats_doc/frames.html).

## Used version
Written with Ruby >= 2.3

## Tested
* Linux: running with Ruby >= 2.3
* Windows: not tested
* MAC: not tested

## Requirements
* csv for file reading

## License
see LICENSE

## Roadmap
* adding query against an index to get result for a given key (done with v0.2.0)
* graphical output for the total occurrence of keys (done as bar chart)
* graphical output for other entry attributes (atm subselect bar chart)
* variable number for top entries
* evaluations for a given time interval
* output of selected entries
* file output of relevant results

created by: Benjamin Held
