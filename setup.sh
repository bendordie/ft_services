# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cshells <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/24 00:38:20 by cshells           #+#    #+#              #
#    Updated: 2021/03/15 19:38:38 by cshells          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

read -n1 -p "
  
        ███ █   █
         █  █   █
         █  ███ █
         █  █ █ █
         █  ███ █

█ █ ████  ███ ████ ███ █  █ ███
█ █ █  ██ █   █  █ █   █  █   █
███ ████  ███ ████ ███ ████ ███
  █ █  ██ █   █    █   █  █
███ ████  ███ █    ███ █  █ █

[y/N] " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
   
echo "

█   █ ███ ████ █   █
█ █ █  █  █  █ █ █ █
█ █ █  █  █  █ █ █ █
█ █ █  █  █  █ █ █ █
█████  █  ████ █████ █ █ █

"
    minikube stop
    minikube delete

    #init kubernetes cluster
    minikube start --vm-driver=virtualbox
    
    #if smthing goes wrong with MetalLB
    eval $(minikube docker-env)
    docker pull metallb/speaker:v0.8.2
    docker pull metallb/controller:v0.8.2
    minikube addons enable metallb

    #redirect docker commands to k8s cluster
    eval $(minikube docker-env)

    #turn ON LoadBalancer
    minikube addons enable metallb

    kubectl apply -f ./srcs/mysql/mysql-volume.yaml
    kubectl apply -f ./srcs/mysql/mysql-pv-claim.yaml
    kubectl apply -f ./srcs/influxdb/influxdb-volume.yaml
    kubectl apply -f ./srcs/influxdb/influxdb-pv-claim.yaml

    #build docker-images in k8s cluster
    docker build -t nginx-img ./srcs/nginx
    docker build -t wp-img ./srcs/wordpress
    docker build -t pma-img ./srcs/phpmyadmin
    docker build -t mysql-img ./srcs/mysql
    docker build -t influx-img ./srcs/influxdb
    docker build -t ftps-img ./srcs/ftps
    docker build -t grafana-img ./srcs/grafana

    #appl k8s manifests
    kubectl apply -f ./srcs/configmap.yaml
    kubectl apply -f ./srcs/nginx/nginx.yaml
    kubectl apply -f ./srcs/wordpress/wordpress.yaml
    kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
    kubectl apply -f ./srcs/mysql/mysql.yaml
    kubectl apply -f ./srcs/influxdb/influxdb.yaml
    kubectl apply -f ./srcs/ftps/ftps.yaml
    kubectl apply -f ./srcs/grafana/grafana.yaml
    
fi


