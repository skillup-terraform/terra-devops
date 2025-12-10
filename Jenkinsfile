pipeline {
    agent any
    
    environment {
        // These come from Jenkins credentials binding
        ARM_CLIENT_ID     = credentials('azure_client_id')
        ARM_CLIENT_SECRET = credentials('azure_client_secret')
        ARM_TENANT_ID = "d7a7dafa-5952-439d-b904-78bf6a481c7d"
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh """
                    terraform ini  
                """
            }
        }

        stage('Terraform Plan 1 (PR Only)') {
            when {
                expression { env.CHANGE_ID != null }   // Only pull requests
            }
            steps {
                echo "Pull Request detected! PR Number: ${env.CHANGE_ID}"
                echo "Running terraform plan..."

                sh """
                    terraform plan
                """
            }
        }

        stage('Terraform Plan 2 (PR Only)') {
            when {
                expression { env.CHANGE_ID != null }   // Only pull requests
            }
            steps {
                echo "Pull Request detected! PR Number: ${env.CHANGE_ID}"
                echo "Running terraform plan..."

                sh """
                    terraform plan
                """
            }
        }

        stage('Terraform Apply (Main Branch Only)') {
            when {
                branch 'main'
                expression { env.CHANGE_ID == null }  // Not a PR, only normal main push
            }
            steps {
                echo "Main branch commit detected—running terraform apply..."

                sh """
                    terraform apply --auto-approve
                """
            }
        }
    }
    
}