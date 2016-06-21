# Nginx Statistics

Ruby program to evaluate the log files of nginx. At the moment the basic script
shows the top 10 entries of the given entry attribute. These attributs are the
timestamp of the entry, the source ip, the http status and the http request.

## Usage & Help
```
script usage: ruby <script>
help usage :  ruby <script> (-h | --help)

nginx_statistic help:
 -h, --help     show help text
 -v, --version  prints the current version of the project
```

## Documentation
Documentation is written in yard and can be created by running the shell-script
`create_yard.sh`. Yard needs to be installed on the system in order to do that.

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

created by: Benjamin Held
