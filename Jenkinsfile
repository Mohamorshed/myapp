pipeline {
 agent any

    environment { 
        registry = "morshed983/morshed983" 
        registryCredential = 'docker-hub'
    }
    stages { 
         

        stage('Building our image') { 
           
            steps { 

                script { 

                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 

                }

            } 

        }

        stage('Deploy our image') {  
            steps { 

                script { 

                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                }
            } 
        }
    }    
        
        stage('Cleaning up') { 
            steps { 

                sh "docker rmi $registry:$BUILD_NUMBER" 
                
            }
        }
            
        stage('Deploy  Application') {  
                  steps {
                   withCredentials([file(credentialsId: 'config', variable: 'config')])
                  {                   
             
                    sh  "cat app.yml | envsubst > myfile && mv myfile app.yml"
                    sh  "kubectl apply -f app.yml --kubeconfig $config"
                    sh  "kubectl apply -f myservice.yml --kubeconfig $config"
                   
                  }
                    
            }
                                                         
        } 
    }
}    
