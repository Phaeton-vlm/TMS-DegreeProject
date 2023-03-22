folder('Infrastructure') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Infrastructure management folder</div>')
}


pipelineJob('Infrastructure/Infrastructure_deploy') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Create infrastructure pipeline</div>')
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        github('Phaeton-vlm/TMS-DegreeProject', 'ssh')
                        credentials('github_ssh')
                    }
                    branch('main')
                }
            }
            scriptPath('infrastructure/Kubernetes/Jenkinsfile_create')
        }
    }
}

pipelineJob('Infrastructure/Infrastructure_destroy') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Destroy infrastructure pipeline</div>')
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        github('Phaeton-vlm/TMS-DegreeProject', 'ssh')
                        credentials('github_ssh')
                    }
                    branch('main')
                }
            }
            scriptPath('infrastructure/Kubernetes/Jenkinsfile_destroy')
        }
    }
}

folder('App') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Application management folder</div>')
}

pipelineJob('App/app_build') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Build application pipeline</div>')
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        github('Phaeton-vlm/todo-vue')
                    }
                    branch('master')
                }
            }
            scriptPath('Jenkinsfile_build')
        }
    }
}