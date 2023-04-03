FROM jenkins/agent:latest

USER root
RUN apt-get update && apt-get install -y gettext-base

# aws cli installation
RUN mkdir -p /home/jenkins/.kube && chown -R jenkins /home/jenkins/.kube; \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    apt install unzip; \
    unzip awscliv2.zip; \
    ./aws/install

# helm installation
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3; \
    chmod 700 get_helm.sh; \
    ./get_helm.sh
    
USER jenkins