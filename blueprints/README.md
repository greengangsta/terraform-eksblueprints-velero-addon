# Deployment Instructions

## Update Variables

```sh
cd vars
# Edit config.tfvars
cd ..
```

## Create VPC

```sh
cd vpc
terraform init -backend-config=vpc.tfbackend
terraform apply -auto-approve --var-file=../vars/config.tfvars
export TF_VAR_vpc_id=$(terraform output -json | jq -r '.vpc_id.value')
cd ..
```

## Create EKS Cluster

```sh
cd eks
terraform init -backend-config=eks.tfbackend
terraform apply -auto-approve --var-file=../vars/config.tfvars
export TF_VAR_eks_cluster_id=$(terraform output -json | jq -r '.["aws-eks-accelerator-for-terraform"].value.eks_cluster_id')
export CONFIGURE_KUBECTL=$(terraform output -json | jq -r '.["aws-eks-accelerator-for-terraform"].value.configure_kubectl')
cd ..
```

## Create Add-on

```sh
cd addons
terraform init -backend-config=addons.tfbackend
terraform apply -auto-approve --var-file=../vars/config.tfvars
cd ..
```

## Update KubeConfig

```sh
$(echo $CONFIGURE_KUBECTL)
```

## Verify that velero addon is running

```sh
kubectl get all -n velero

NAME                          READY   STATUS    RESTARTS   AGE
pod/velero-78b8ddfc56-jmkdm   1/1     Running   0          10m

NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/velero   ClusterIP   172.20.47.185   <none>        8085/TCP   10m

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/velero   1/1     1            1           10m

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/velero-78b8ddfc56   1         1         1       10m

```

## Get backup location 

```sh

velero backup-location get

NAME      PROVIDER   BUCKET/PREFIX                                    PHASE     LAST VALIDATED   ACCESS MODE   DEFAULT
default   aws        eks-tf-velero-backup20220410090713882000000001   Unknown   Unknown          ReadWrite  


```
