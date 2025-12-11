pipeline {
    agent any
    options { timestamps() }
        environment {
        // These come from Jenkins credentials binding
        ARM_CLIENT_ID     = credentials('azure_client_id')
        ARM_CLIENT_SECRET = credentials('azure_client_secret')
        ARM_TENANT_ID = "d7a7dafa-5952-439d-b904-78bf6a481c7d"
    }

    stages {

        stage('Detect PR or Merge') {
            steps {
                script {
                    IS_PR = env.CHANGE_ID ? "true" : "false"
                    PR_NUMBER = env.CHANGE_ID ?: ""
                    SOURCE_BRANCH = env.CHANGE_BRANCH ?: env.BRANCH_NAME
                    TARGET_BRANCH = env.CHANGE_TARGET ?: ""
                    COMMIT_SHA = env.GIT_COMMIT

                    echo """
                    ===== Build Context =====
                    PR: ${IS_PR}  (PR #${PR_NUMBER})
                    Source Branch: ${SOURCE_BRANCH}
                    Target Branch: ${TARGET_BRANCH}
                    Commit: ${COMMIT_SHA}
                    =========================
                    """
                }
            }
        }

        stage('Get Changed Files') {
            steps {
                script {
                    sh "git fetch --all"

                    def target = TARGET_BRANCH ?: "origin/${SOURCE_BRANCH}"

                    changedFiles = sh(
                        script: "git diff --name-only origin/${target}",
                        returnStdout: true
                    ).trim().split("\n")

                    echo "Changed Files:\n${changedFiles.join('\n')}"
                }
            }
        }

        stage('Detect Environment') {
            steps {
                script {
                    ENVIRONMENT = ""

                    if (changedFiles.any { it.startsWith("envs/dev/") }) {
                        ENVIRONMENT = "dev"
                    }
                    if (changedFiles.any { it.startsWith("envs/qa/") }) {
                        ENVIRONMENT = "qa"
                    }
                    if (changedFiles.any { it.startsWith("envs/prod/") }) {
                        ENVIRONMENT = "prod"
                    }

                    if (!ENVIRONMENT) {
                        error "No environment changes detected in envs/dev|qa|prod"
                    }

                    echo "Detected Environment: ${ENVIRONMENT.toUpperCase()}"
                }
            }
        }

        // stage('Checkout Exact Commit') {
        //     steps {
        //         script {
        //             echo "Checking out commit ${COMMIT_SHA}"
        //             checkout([
        //                 $class: 'GitSCM',
        //                 branches: [[name: COMMIT_SHA]],
        //                 userRemoteConfigs: [[url: "https://github.com/your-org/your-repo.git"]]
        //             ])
        //         }
        //     }
        // }

        stage('Run Env Tasks') {
            steps {
                script {
                    sh """
                        export ARM_CLIENT_ID='${env.ARM_CLIENT_ID}'
                        export ARM_CLIENT_SECRET='${env.ARM_CLIENT_SECRET}'
                        export ARM_TENANT_ID='${env.ARM_TENANT_ID}'
                    """
                    if (IS_PR == "true") {
                        echo "Running PR validation for ${ENVIRONMENT.toUpperCase()}"

                        if (ENVIRONMENT == "dev") {
                            sh "echo Deploying to DEV"
                            // sh """
                            //     pwd
                            //     cd ./envs/dev
                            //     pwd
                            //     terraform init
                            //     terraform plan
                            // """
                        }
                        if (ENVIRONMENT == "qa") {
                            sh "echo Deploying to QA"
                            sh """
                                terraform init
                                terraform plan
                            """
                        }
                        if (ENVIRONMENT == "prod") {
                            sh "echo Deploying to PROD"
                            sh """
                                terraform init
                                terraform plan
                            """
                        }
                    }
                    else {

                        echo "Running MERGE deployment for ${ENVIRONMENT.toUpperCase()}"

                        if (ENVIRONMENT == "dev") {
                            sh "echo Deploying to DEV"
                            sh """
                                terraform init
                                terraform plan
                            """
                        }
                        if (ENVIRONMENT == "qa") {
                            sh "echo Deploying to QA"
                        }
                        if (ENVIRONMENT == "prod") {
                            sh "echo Deploying to PROD"
                        }
                    }
                }
            }
        }
    }
}
