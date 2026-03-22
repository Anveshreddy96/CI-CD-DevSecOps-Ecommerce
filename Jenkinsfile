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
                    mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=E-commerceProject1 
                    '''
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
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '3.23.59.37:8081',
                    groupId: 'com.mycompany',
                    version: '1.0.0',
                    repository: 'maven-releases',
                    credentialsId: 'nexus-cred',
                    artifacts: [
                        [artifactId: 'myweb', classifier: '', file: 'target/myweb-8.7.3.war', type: 'war']
                    ]
                )
            }
        }
        stage ("Deploy") {
            steps {
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'appserver',
                        path: '',
                        url: 'http://3.14.8.175:8080',
                        contextPath: 'myapp'
                    )
                ],
                war: 'target/myweb-8.7.3.war'
            }
        }
