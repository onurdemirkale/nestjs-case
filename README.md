
# Improvements:

- Implement a versioning system. Currently, the commit hash is used as the image tag. 

# Issues:

- If the same GCR is used for develop and production branches, there might be issues on rollback. For example, we want to rollback the deployments on the 'prod' namespace, the 'latest' image will no longer be valid. Versioning is necessary to overcome this issue. 

# Followed Steps:

## Infrastructure

### GKE

- Created a Kubernetes cluster using GKE. Set Kubernetes context to the GKE cluster. 

- Created `stage` and `production` namespaces in the Kubernetes cluster.

- Used the default GKE service account to create a JSON key for authentication.

- Uploded the JSON key to Circle CI environment variables to be accessed during the deployment process.

### GCR

- Enabled GCR API and created a GCR. 

- Created a service account for the GCR. Obtained a JSON key for authentication.

- Uploded the JSON key to Circle CI environment variables to be accessed during the repository push process.

### Circle CI

- Enable GitHub Checks in Organization Settings on the VCS tab of CircleCI.

- Create the Circle CI configuration document.

### GitHub

- Edit branch protection rules for `master` and `develop` and require the `test_node_12` job as a status check. This allows to run unit tests before a branch can be merged.

# Configuration: 

## Github

- Add the unit test jobs on branches master and develop.

## Circle CI Environment Variables:

Set the following environment variables in your CircleCI project settings:

`CIRCLE_BRANCH`: This environment variable is automatically set by CircleCI and contains the name of the Git branch being built.

`GCR_PROJECT`: This variable should contain the Google Cloud project ID where the Google Container Registry (GCR) is hosted.

`GCR_SERVICE_ACCOUNT_KEY`: This variable should contain the JSON key for the Google Cloud service account that has access to your Google Container Registry (GCR). The key is used to authenticate with GCR for pushing Docker images.

`GKE_SERVICE_ACCOUNT_KEY`: This variable should contain the JSON key for the Google Cloud service account that has access to your Google Kubernetes Engine (GKE) cluster. The key is used to authenticate with GKE for deploying your application.

`GKE_PROJECT`: This variable should contain the Google Cloud project ID where your Google Kubernetes Engine (GKE) cluster is hosted.

`GKE_ZONE`: This variable should contain the Google Cloud zone where your Google Kubernetes Engine (GKE) cluster is located.

`GKE_CLUSTER`: This variable should contain the name of your Google Kubernetes Engine (GKE) cluster.
