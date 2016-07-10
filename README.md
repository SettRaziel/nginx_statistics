# Nginx Statistics

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
* none

## License
see LICENSE

## Roadmap
* adding query against an index to get result for a given key
* graphical output for the total occurrence of keys or other entry attributes
* evaluations for a given time interval

created by: Benjamin Held
