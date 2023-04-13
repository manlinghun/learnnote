~~~shell
docker run -d --name=grafana -p 3000:3000 grafana/grafana

docker run -d --name myprometheus2 -p 9090:9090 prom/prometheus:latest

docker run -d  --name mynodeexport -p 9100:9100  prom/node-exporter:latest

# 关闭防火墙
systemctl status firewalld.service
systemctl stop firewalld.service
systemctl disable firewalld.service
~~~


[Grafana](http://192.168.31.19:3000) admin/123456
[Prometheus](http://192.168.31.19:9090)
[node-exporter](http://192.168.31.19:9100)


