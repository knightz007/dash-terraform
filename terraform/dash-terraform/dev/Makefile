
create-cluster:
	cd /c/Users/anupk/DevOpsRepo/terraform/dash-terraform/dev/k8_cluster;\
	terraform apply -auto-approve;
create-helm-rbac: create-cluster
	cd /c/Users/anupk//DevOpsRepo/terraform/dash-terraform/dev/k8_cluster; \
	CLUSTER_MASTER_IP=`terraform output cluster_master_ip`; \
	cd /c/Users/anupk/DevOpsRepo/terraform/dash-terraform/dev/helm_rbac; \
	terraform apply -var cluster_master_ip=$$CLUSTER_MASTER_IP -auto-approve
create-apps: create-cluster create-helm-rbac
	cd /c/Users/anupk//DevOpsRepo/terraform/dash-terraform/dev/k8_cluster; \
	CLUSTER_MASTER_IP=`terraform output cluster_master_ip`; \
	cd /c/Users/anupk/DevOpsRepo/terraform/dash-terraform/dev/helm_apps;\
	terraform apply -var cluster_master_ip=$$CLUSTER_MASTER_IP -auto-approve

destroy-apps:
	cd /c/Users/anupk//DevOpsRepo/terraform/dash-terraform/dev/k8_cluster; \
	CLUSTER_MASTER_IP=`terraform output cluster_master_ip`; \
	cd /c/Users/anupk/DevOpsRepo/terraform/dash-terraform/dev/helm_apps;\
	terraform destroy -var cluster_master_ip=$$CLUSTER_MASTER_IP -auto-approve

destroy-helm-rbac:
	cd /c/Users/anupk//DevOpsRepo/terraform/dash-terraform/dev/k8_cluster; \
	CLUSTER_MASTER_IP=`terraform output cluster_master_ip`; \
	cd /c/Users/anupk/DevOpsRepo/terraform/dash-terraform/dev/helm_rbac; \
	terraform destroy -var cluster_master_ip=$$CLUSTER_MASTER_IP -auto-approve

destroy-cluster: destroy-apps destroy-helm-rbac
	cd /c/Users/anupk//DevOpsRepo/terraform/dash-terraform/dev/k8_cluster; \
	terraform destroy -auto-approve



