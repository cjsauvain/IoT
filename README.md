# IoT

## Part 1: K3s and Vagrant

### Installation

```bash
cd p1
vagrant up
```

### Usage

```bash
# Connect to the VMs
vagrant ssh afabyS
vagrant ssh afabySW

# From afabyS: check that both nodes are part of the cluster
sudo kubectl get nodes -o wide

# Check the IP of the private interface
ip a show eth1
```

Both nodes `afabyS` and `afabySW` should be listed as `Ready`.

### Cleanup

```bash
vagrant destroy -f
```

---

## Part 2: K3s and three applications

### Installation

```bash
cd p2
vagrant up
```

### Usage

From the host machine:

```bash
curl -H "Host: app1.com" http://192.168.56.110   # Hello from app1.
curl -H "Host: app2.com" http://192.168.56.110   # Hello from app2.
curl http://192.168.56.110                       # Hello from app3.
```

From the browser:

```
Add to /etc/hosts:

192.168.56.110 app1.com
192.168.56.110 app2.com
192.168.56.110 app3.com
```
```
You can now open the following urls from your browser:

app1.com
app2.com
app3.com
http://192.168.56.110

```

To inspect the cluster:

```bash
vagrant ssh afabyS
sudo kubectl get all -n <namespace>
```

### Cleanup

```bash
vagrant destroy -f
```

---

## Part 3: K3d and Argo CD

### Installation

```bash
cd p3

# Install Docker and K3d if they are missing
bash scripts/install.sh

# Optional: use Docker without sudo (then log out and back in)
sudo usermod -aG docker $USER

# Create the cluster and namespaces, install Argo CD and the Application
make
```

### Usage

```bash
# Follow Argo CD startup
kubectl get pods -n argocd

# Check the application deployed in dev
kubectl get pods -n dev
```

Access the Argo CD UI:

```bash
make password   # initial password of the admin user
make forward    # port-forward, keep it running
```

Then open <https://localhost:8080> (user `admin`).

### Cleanup

```bash
make clean

# Uninstall Docker and K3d (also removes /var/lib/docker)
bash scripts/uninstall.sh
```

---

## Bonus: Local GitLab

### Installation

```bash
cd bonus

# Install Docker and K3d if they are missing
bash scripts/install.sh

# Optional: use Docker without sudo (then log out and back in)
sudo usermod -aG docker $USER

# Create the cluster and namespaces, install Argo CD, GitLab and the Application
make
```

### GitLab repository setup

1. Open <http://localhost:8889> and log in with:
   - user: `root`
   - password: `SuperSecret42!!` (set in [install.yaml](bonus/confs/gitlab/install.yaml))
2. Create a **public** project named `iot-bonus-jsauvain` in the `root` namespace (public so that Argo CD can clone it without credentials).
3. Push the application manifests (Deployment + Service exposed on port `8888`) to the root of the repository:

```bash
git clone http://localhost:8889/root/iot-bonus-jsauvain.git
cd iot-bonus-jsauvain
# add the manifests (for example the ones from the repository used in p3)
git add . && git commit -m "init" && git push
```

### Usage

```bash
# Access the application
curl http://localhost:8888

# Argo CD UI
make password
make forward    # then https://localhost:8080 (user admin)
```

### Cleanup

```bash
make clean
bash scripts/uninstall.sh   # uninstall Docker and K3d
```
