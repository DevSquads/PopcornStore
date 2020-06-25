# Popcorn Store

Popcorn Store MVP

### Ruby version 2.7.1

## System dependencies
### Docker
* install [docker](https://docs.docker.com/install/)
### Docker-compose
* install [docker-compose](https://docs.docker.com/compose/install/)
## How to run
* Get source code   
```git clone git@github.com:DevSquads/PopcornStore.git && cd ./PopcornStore```
* Build  
```docker-compose build```
* Run   
```docker-compose up```
## How to run the test suite
* Go into the docker application container   
```docker exec -it popcornstore_application_1 /bin/bash```
* Run   
```rspec```
### or just
```docker run -it popcornstore_application_1 rspec```