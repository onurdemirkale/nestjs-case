
## Workflow: 

- A new feature has been developed. 

- The feature has been committed and a pull request on to the 'develop' branch has been opened from a feature branch. 

- The tests are successful, the image is succesfully built and the image has been pushed to the GCR. 

- The deployment is performed on the Circle CI configuration through GKE on 'staging' namespace.

- If there is a pull request from 'develop' on the 'production', the deployment is performed on 'prod' namespace. 

## Improvements:

- Implement a versioning system. Currently, the commit hash is used as the image tag. 

## Possible issues:

- If the same GCR is used for develop and production branches, there might be issues on rollback. For example, we want to rollback the deployments on the 'prod' namespace, the 'latest' image will no longer be valid. Versioning is necessary to overcome this issue. 

## Keypoints:

- GKE is easy to setup and maintain. Although I have more experience with EKS, GKE is easier to start with. 

## Steps

- Environment variables are set manually on the Circle CI.

- Set the following environment variables on Circle CI:

  - 

## GCR

- Enabled GCR API and created a GCR.

- Created a service account for the GCR.

## GKE

- Used the default GKE service account. Created a JSON key.

- Authenticated to GCP and enabled GKE context.

- Created `stage` and `production` namespaces in the Kubernetes cluster.
