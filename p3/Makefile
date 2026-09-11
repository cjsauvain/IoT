CLUSTER_NAME = p3
ARGOCD_NS = argocd
DEV_NS = dev

run: cluster namespaces argocd

cluster:
	k3d cluster create $(CLUSTER_NAME) -p "8888:8888@loadbalancer"

namespaces:
	kubectl create namespace $(ARGOCD_NS)
	kubectl create namespace $(DEV_NS)

argocd:
	kubectl apply -n $(ARGOCD_NS) -f config/argocd/install.yaml --server-side --force-conflicts

password:
	kubectl -n $(ARGOCD_NS) get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

argocd_pods:
	kubectl get pods -n $(ARGOCD_NS)

forward:
	kubectl port-forward svc/argocd-server -n $(ARGOCD_NS) 8080:443

clean:
	k3d cluster delete $(CLUSTER_NAME)

re: clean run

