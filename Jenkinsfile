pipeline {
    agent any
    tools {
        maven "mymaven"
    }
    stages {
        stage ("Code") {
            steps {
                git branch: 'main', url: 'https://github.com/Anveshreddy96/CI-CD-DevSecOps-Ecommerce.git'
            }
        }
        stage ("CQA") {
            steps {
                withSonarQubeEnv('mysonar') {
                    sh '''
                        mvn sonar:sonar \
                        -Dsonar.projectKey=E-commerceProject1 \
                     '''
                    }
                }
            }
        }
        stage ("Build&Test") {
            steps {
                sh 'mvn clean package'
            }
        }
        stage ("Artifact") {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'myweb', classifier: '', file: 'target/myweb-8.7.3.war', type: 'war']], credentialsId: 'nexus', groupId: 'in.javahome', nexusUrl: '3.138.193.73:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'ecommerce-repo', version: '8.7.3'
            }
        }
        stage ("Deploy") {
            steps {
                deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'appserver', path: '', url: 'http://3.14.8.175:8080/')], contextPath: 'myapp', war: 'target/*.war'
            }
        }
    }
}
