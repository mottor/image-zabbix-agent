# How to update Docker Hub's version

1. Залогиниться

       docker login 
       ## Enter login and pass

2. Увеличить номер версии в файле VERSION.md

3. Запустить команду:

       docker build -t mottor1/zabbix-agent . ; \
       for i in $(cat VERSION.md | head -n 1) "latest"; do \
       printf "\n------\npushing '${i}'\n"; \
       docker tag mottor1/zabbix-agent "mottor1/zabbix-agent:${i}"; \
       docker push "mottor1/zabbix-agent:${i}"; \
       done
