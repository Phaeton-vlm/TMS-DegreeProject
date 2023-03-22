FROM jenkins/agent:latest

USER root
RUN apt-get update && apt-get install -y gettext-base
RUN mkdir -p /home/jenkins/.kube && chown -R jenkins /home/jenkins/.kube
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN apt install unzip
RUN unzip awscliv2.zip
RUN ./aws/install
USER jenkins