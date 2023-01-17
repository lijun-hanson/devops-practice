# devops-practice
One devops practice

## Table of Content

 * [Overview](#overview)
 * [Usage](#usage)
 * [Appendix](#appendix)

## Overview
This is a devops practice example by using IaC(Terraform) and config-driven(Helm) tool 
to create AKS cluster and deploy service and add-ons in the cluster.

## Usage
Configure your own azure credential for cli tool, and go into **terraform** folder to 
deploy AKS cluster by following steps:
```bash
terraform init
terraform plan
terraform apply # enter yes to proceed when asked
```

Use following command to attach existing ACR to your AKS as trusted repository:
```azurecli
az aks update -n <aks-name> -g <resource-group> --attach-acr <acr-id>
```

Then go into **helm** folder to deploy example service and add-ons to AKS
```bash
# update helm repos and dependency artifacts in add-ons
helm dependency update
# deploy add-ons including ingress-nginx-controller and prometheus stack
helm upgrade --install -n kube-system -f add-ons/values.yaml add-ons add-ons
# deploy service example
helm upgrade --install -f services/values.yaml services services
```

Finally, you could access service via hosts defined in values.yaml in **add-ons**, 
access following portals, the bottom 3 add-ons' access is controlled by basic auth:
- example service via [hansonli-svc.mooo.com](http://hansonli-svc.mooo.com)
- prometheus UI via [hansonli.mooo.com](http://hansonli.mooo.com)
- alertmanager UI via [hansonli.mooo.com/aler](http://hansonli.mooo.com/aler)
- grafana UI via [hansonli.mooo.com/graf](http://hansonli.mooo.com/graf)

## Appendix
The DNS is registered in [FreeDNS](https://freedns.afraid.org/) website.
