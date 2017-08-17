
node('master') {
    
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '0054d1d9-f36b-4da9-a7b5-9af8d309d4ee', url: 'git@github.com:fane247/devops-node-test-app.git']]])
    
    sshagent(['7ba76d35-94fb-461f-8370-e3b6453dcc6c']) {
       
        
        stage('testing'){
            
            sh 'ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.139.238 sudo rm -rf "/home/ubuntu/app"'
            sh 'scp -o "StrictHostKeyChecking=no" -r ./ ubuntu@18.220.139.238:/home/ubuntu/app'

            sh 'knife zero bootstrap 18.220.139.238 --overwrite --ssh-user ubuntu --node-name testing'
            sh 'knife zero converge "name:testing" --ssh-user ubuntu --override-runlist node_app'


            
            sh  '''ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.139.238 << EOF
                
                echo provisioning
                pm2 kill
            	cd /home/ubuntu/app
                export "DB_HOST=mongodb://192.168.10.102/test"
            	npm install
                npm test
            
            '''
            
        }
        
        stage('deployment'){
        
            sh 'echo deploying'
            sh 'ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.63.196 sudo rm -rf "/home/ubuntu/app"'
            sh 'scp -o "StrictHostKeyChecking=no" -r ./ ubuntu@18.220.63.196:/home/ubuntu/app'

            sh 'knife zero bootstrap 18.220.63.196 --overwrite --ssh-user ubuntu --node-name production'
            sh 'knife zero converge "name:production" --ssh-user ubuntu --override-runlist node_app'
            
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.63.196 << EOF

            	cd /home/ubuntu/app
                export "DB_HOST=mongodb://192.168.10.102/test"
            	npm install
                pm2 start app.js -f
            '''
        }
    }
}