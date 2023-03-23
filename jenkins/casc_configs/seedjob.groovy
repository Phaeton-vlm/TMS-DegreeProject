folder('Infrastructure') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Infrastructure management folder</div>')
}


pipelineJob('Infrastructure/Deploy_Infrastructure') {
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

pipelineJob('Infrastructure/Destroy_infrastructure') {
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

multibranchPipelineJob('App/Build(multibranch)') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Build application pipeline</div>')
    branchSources {
        branchSource {
            source {
                github {
                    id('1234567') // IMPORTANT: use a constant and unique identifier
                    repoOwner('Phaeton-vlm')
                    repository('todo-vue')
                    repositoryUrl('https://github.com/Phaeton-vlm/todo-vue.git')
                    configuredByUrl(true)
                    traits {
                        gitHubBranchDiscovery {
                            strategyId(3)
                        }
                        gitHubPullRequestDiscovery {
                            strategyId(1)
                        }
                        headWildcardFilter  {
                            includes("master PR-*")
                            excludes("")
                        }
                    }
                }
            }
        }
    }

    factory {
        workflowBranchProjectFactory {
            scriptPath('Jenkinsfile_build')
        }
    }

    orphanedItemStrategy {
        discardOldItems {
            numToKeep(15)
        }
    }
}

pipelineJob('App/Deploy') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">BuiDeployld application pipeline</div>')
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
            scriptPath('Jenkinsfile_deploy')
        }
    }
}