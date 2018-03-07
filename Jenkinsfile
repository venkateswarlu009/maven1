pipeline {
  agent any
  stages {
    stage('deve') {
      steps {
        echo 'etst'
        build(job: 'testjob', quietPeriod: -1)
        build(job: 'testingjob', quietPeriod: 1, wait: true)
      }
    }
    stage('test') {
      steps {
        sh 'echo \'testing stage\''
      }
    }
    stage('deply') {
      steps {
        ws(dir: '/var/lib/jenkins/maven1/target')
      }
    }
  }
}