pipeline {
    agent any 
    stages {
        stage('Build Docker image') {
            steps {
                sh 'cd ~/ros2_ws/src/ros2_ci && sudo docker buildx build -f dockerfile_tortoisebot_waypoints -t ros2-tortoisebot-waypoints .'
            }
        }
        stage('Run container') {
            steps {
                sh 'cd ~/ros2_ws/src/ros2_ci && sudo docker run --name test-ros2 -d --rm -v ./test-script.sh:/test-script.sh -v /tmp/.X11-unix:/tmp/.X11-unix \
                -e DISPLAY=$DISPLAY ros2-tortoisebot-waypoints:latest'
                sleep 5
            }
        }
        stage('Run test') {
            steps {
                sh 'sudo docker exec test-ros2 /test-script.sh'
            }
        }
    }
    post {
            always {
                sh 'sudo docker stop test-ros2'
                sh 'sudo docker rmi ros2-tortoisebot-waypoints:latest'
                sh 'sudo docker image prune -f'
                sh 'sudo docker container prune -f'
            }
        }
}
