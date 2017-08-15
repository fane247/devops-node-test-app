
node('master') {
    
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '0054d1d9-f36b-4da9-a7b5-9af8d309d4ee', url: 'git@github.com:fane247/devops-node-test-app.git']]])
    
    sshagent(['7ba76d35-94fb-461f-8370-e3b6453dcc6c']) {
       
        
        stage('testing'){
            
            sh 'ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.139.238 rm -rf "/home/ubuntu/app"'
            sh 'scp -o "StrictHostKeyChecking=no" -r ./ ubuntu@18.220.139.238:/home/ubuntu/app'
            
            sh  '''ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.139.238 << EOF
                
                echo provisioning
                pm2 kill
            	cd /home/ubuntu/app
                export "DB_HOST=mongodb://192.168.10.102/test"
                curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
                berks install
                sudo chef-client --local-mode --runlist "recipe[node-sever]"
                //  ./environment/box_web/provisioning.sh
            	npm install
                npm test
            
            '''
            
        }
        
        stage('deployment'){
        
            sh 'echo deploying'
            sh 'ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.63.196 rm -rf "/home/ubuntu/app"'
            sh 'scp -o "StrictHostKeyChecking=no" -r ./ ubuntu@18.220.63.196:/home/ubuntu/app'
            
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@18.220.63.196 << EOF

            	cd /home/ubuntu/app
                export "DB_HOST=mongodb://192.168.10.102/test"
                curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
                berks install
                sudo chef-client --local-mode --runlist "recipe[node-sever]"
                // ./environment/box_web/provisioning.sh
            	npm install
                pm2 start app.js -f
            '''
        }
    }
}