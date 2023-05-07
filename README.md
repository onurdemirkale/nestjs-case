
# Improvements:

- Implement a versioning system. Currently, the commit hash is used as the image tag. 

# Issues:

- Tests are triggered every commit. Configure the tests to only run during pull request events.

# Workflow:

GitHub status checks have been enabled and integrated with CircleCI. Whenever a pull request is opened, the `test` workflow is required as a status check before the pull request can be merged. No direct commits are allowed on `develop` or `master` branches. Whenever a commit is added to the protected `develop` or `master` branches, the `build_and_deploy` workflow is triggered. This workflow builds a Docker image and tags it using the commit hash. Finally, the image of a Kubernetes deployment is updated using rolling update. The namespace is determined according to the branch name. 

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

- Enabled GitHub Checks in Organization Settings on the VCS tab of CircleCI.

- Created the Circle CI configuration document.

- Configured the `test` workflow to run on all commits and be required by all pull requests as a status check before a pull request can be merged.

### Dockerfile

- Implemented a Dockerfile for the Nest.js application.

### K8S

- Implemented a deployment manifest.

### GitHub

- Edited branch protection rules for `master` and `develop` and added the `test` workflow as a status check. This allows to run unit tests before a branch can be merged.

# Configuration: 

## Github

- Enable the following branch protection rules:

  - Require a pull request before merging

  - Require status checks to pass before merging

  - Require branches to be up to date before merging 

- Add the unit test workflow as status checks on branches master and develop.

## Circle CI

- Enable GitHub Status Checks in Organization Settings under the VCS tab of CircleCI.

Set the following environment variables in your CircleCI project settings:

- `CIRCLE_BRANCH`: This environment variable is automatically set by CircleCI and contains the name of the Git branch being built.

- `GCR_PROJECT`: This variable should contain the Google Cloud project ID where the Google Container Registry (GCR) is hosted.

- `GCR_SERVICE_ACCOUNT_KEY`: This variable should contain the JSON key for the Google Cloud service account that has access to your Google Container Registry (GCR). The key is used to authenticate with GCR for pushing Docker images.

- `GKE_SERVICE_ACCOUNT_KEY`: This variable should contain the JSON key for the Google Cloud service account that has access to your Google Kubernetes Engine (GKE) cluster. The key is used to authenticate with GKE for deploying your application.

- `GKE_PROJECT`: This variable should contain the Google Cloud project ID where your Google Kubernetes Engine (GKE) cluster is hosted.

- `GKE_ZONE`: This variable should contain the Google Cloud zone where your Google Kubernetes Engine (GKE) cluster is located.

- `GKE_CLUSTER`: This variable should contain the name of your Google Kubernetes Engine (GKE) cluster.
