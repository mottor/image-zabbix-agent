# image-zabbix-agent

Образ zabbix-agent, который запускается в Docker.

Скопировано с https://github.com/zabbix/zabbix-docker/tree/6.0/Dockerfiles/agent2/alpine, т.к.
нужно было внести изменения в docker-entrypoint.sh

Особенности: 
- имеет установленный mysql-client.

[Docker Hub Link](https://hub.docker.com/r/mottor1/zabbix-agent)

Command to use:

    docker pull mottor1/zabbix-agent

Grant zabbix to connect:

    grant replication client on *.* to 'zabbix'@'172.%.%.%' identified by 'zabbix';

Docker-compose:

    zabbix-agent:
    image: 'mottor1/zabbix-agent:latest'
    container_name: pdns_zabbix_agent
    restart: always
    volumes:
     - '/etc/localtime:/etc/localtime:ro'
     - '/etc/timezone:/etc/timezone:ro'
     - '$PWD/zabbix_agentd.d/:/etc/zabbix/zabbix_agentd.d:ro'
     #- '$PWD/volumes/zabbix-agent/var/lib/zabbix/modules:/var/lib/zabbix/modules:ro'
     #- '$PWD/volumes/zabbix-agent/var/lib/zabbix/enc:/var/lib/zabbix/enc:ro'
     #- '$PWD/volumes/zabbix-agent/var/lib/zabbix/ssh_keys:/var/lib/zabbix/ssh_keys:ro'
     #deploy: {resources: {limits: {cpus: '0.2', memory: 128M}, reservations: {cpus: '0.1', memory: 64M}}, mode: global}
    env_file:
     - .env_[zabbix]()_agent
    user: root
    privileged: true
    pid: host
    network_mode: "host"
    stop_grace_period: 5s
    logging: *default-logging