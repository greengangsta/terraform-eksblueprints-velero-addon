# If you make a contribution of your module in the upstream repo so others can
# others may benefit from it, your customers' module can use the following example to 
# enable your module.
module "kubernetes-addons" {
  source = "github.com/greengangsta/aws-eks-accelerator-for-terraform/modules/kubernetes-addons"

  # My URL for github : "github.com/greengangsta/aws-eks-accelerator-for-terraform/modules/kubernetes-addons"
  # Developer URL : "github.com/askulkarni2/aws-eks-accelerator-for-terraform/modules/kubernetes-addons"

  eks_cluster_id = var.eks_cluster_id

  # Add-ons
  #enable_kube_state_metrics = true
  enable_velero = true
}

## Alternatively, you wish to keep your add-on private, your customers' module can use
## the following example to use your addon. If you follow this model, you will not able
## to use the EKS Blueprints provided addons ArgoCD GitOps repo. However, it is possible
## to bring your own GitOps repo.
##
#module "kube-state-metrics" {
#  source         = "github.com/askulkarni2/kube-state-metrics-addon"
#  eks_cluster_id = var.eks_cluster_id
#}


