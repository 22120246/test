pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "hello_flask_app"
        DOCKER_CONTAINER = "hello_flask_app_container"
        VERSION = "v1"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                // Xây dựng Docker image từ Dockerfile
                sh 'docker build -t runandgo/${DOCKER_IMAGE}:${VERSION} .'
            }
        }

        stage('Connect docker hub') {
            steps {
                // Kết nối với docker hub
                withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
                    sh 'docker push runandgo/${DOCKER_IMAGE}:${VERSION}'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Dừng container cũ (nếu có)
                script {
                    sh 'docker stop ${DOCKER_CONTAINER} || true'
                    sh 'docker rm ${DOCKER_CONTAINER} || true'
                }
                // Chạy container mới
                sh 'docker run -d --name ${DOCKER_CONTAINER} -p 5000:5000 runandgo/${DOCKER_IMAGE}:${VERSION}'
            }
        }
    }

    post {
        always {
            // Hiển thị danh sách container và logs để kiểm tra
            sh 'docker ps -a'
        }
        success {
            echo 'Done updated!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
