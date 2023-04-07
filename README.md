# :computer: Prerequisites
## Software 
- Docker
- Docker Machine
## Credentials
- Copy AWS acces key to TMS-DegreeProject/docker-machine/aws_cred/aws_access_key_id file
- Copy AWS secret key to TMS-DegreeProject/docker-machine/aws_cred/aws_secret_access_key file
- Copy Gmail App Password to TMS-DegreeProject/docker-machine/email_cred/app_password file ([How to get App Password](https://support.google.com/accounts/answer/185833?hl=en))
- Сopy SSH-key for Github to TMS-DegreeProject/docker-machine/ssh_key/id_rsa file
## Configuration
Go to TMS-DegreeProject/jenkins/.env and set the variables (or just skip)
- JENKINS_ADMIN_ID - your jenkins login
- JENKINS_ADMIN_PASSWORD - your jenkins password
- EMAIL - your Gmail for notification
# :globe_with_meridians: Project launch
Go to TMS-DegreeProject/docker-machine and run _create_docker-machine.sh_ 
```bash
cd ./docker-machine
```
```bash
./create_docker-machine.sh
```
Wait until your Jenkins server is configured
# :cloud: Jenkins
Log in to your Jenkins server (By default: login - _admin_, password - _admin_)
# :star: How to deploy the application
> [This](https://github.com/Phaeton-vlm/todo-vue) project is used for deployment
> 
Go to _Dashboard_ -> _Infrastructure_ -> _Deploy_Infrastructure_ and run it (it will take 20 -25 minutes)

This pipeline will install a cluster named _demo-cluster_

To access the app, find a service named _todoapp-s_ and follow the link (USE HTTP):
> _http://<your_load_balancer_url>_

You can also access prometheus and grafana:
- Prometheus
  - Service: stable-kube-prometheus-sta-prometheus
  - Link: _http://<your_load_balancer_url>_:9090
- Grafana
  - Service: stable-grafana
  - Link: _http://<your_load_balancer_url>_  
  - Login: admin
  - Password: prom-operator
# :zap: How to destroy infrastructure
In Jenkins go to _Dashboard_ -> _Infrastructure_ -> _Destroy_Infrastructure_ and run it

To remove the jenkins server, run the command below
```bash
docker-machine rm vlm-jenkins-server
```
