# DOCKER UNINSTALL

if command -v docker >/dev/null 2>&1
then
  sudo apt purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

  sudo rm -rf /var/lib/docker
  sudo rm -rf /var/lib/containerd

  sudo rm /etc/apt/sources.list.d/docker.sources
  sudo rm /etc/apt/keyrings/docker.asc
fi

if command -v k3d >/dev/null 2>&1
then
  sudo k3d cluster delete --all
  sudo rm -rf $(which k3d)
fi



