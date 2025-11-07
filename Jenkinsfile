pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage('Clonar proyecto') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/Daniel-LA0303/spring_apirest_mongo']]
                ])
            }
        }

        stage('Construir JAR con Maven') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

       stage('Desplegar en EC2') {
            steps {
                withEnv(["PATH+SSH=C:\\Windows\\System32\\OpenSSH"]) {
                    bat '''
                    echo ===== DETENIENDO APLICACION EN EC2 =====
                    ssh -i "C:\\Users\\darkso\\.jenkins\\.ssh\\spring-jenkins-cd-pem.pem" ec2-user@100.24.25.195 "pkill -f 'java -jar /home/ec2-user/app.jar' || true"
        
                    echo ===== ELIMINANDO JAR ANTIGUO =====
                    ssh -i "C:\\Users\\darkso\\.jenkins\\.ssh\\spring-jenkins-cd-pem.pem" ec2-user@100.24.25.195 "rm -f /home/ec2-user/app.jar"
        
                    echo ===== COPIANDO NUEVO JAR =====
                    scp -i "C:\\Users\\darkso\\.jenkins\\.ssh\\spring-jenkins-cd-pem.pem" target\\api-spring-boot-mongo.jar ec2-user@100.24.25.195:/home/ec2-user/app.jar
        
                    echo ===== INICIANDO APLICACION EN EC2 =====
                    ssh -i "C:\\Users\\darkso\\.jenkins\\.ssh\\spring-jenkins-cd-pem.pem" ec2-user@100.24.25.195 "nohup java -jar /home/ec2-user/app.jar > /home/ec2-user/app.log 2>&1 &"
        
                    echo ===== DESPLIEGUE COMPLETADO =====
                    '''
                }
            }
        }

    }
}
