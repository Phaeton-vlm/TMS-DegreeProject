FROM jenkins/agent:latest

USER root
RUN apt-get update && apt-get install -y gettext-base
RUN mkdir -p /home/jenkins/.kube && chown -R jenkins /home/jenkins/.kube
USER jenkins