# NOTES.md

This file is for tracking changes, decisions, and important notes about the project.

---

### Dockerfile creation
- I chose Python 3.13. I didn't find anything in the repo that indicated a version of Python, so I went with the latest.
- I chose to use run.sh as the entrypoint instead of directly calling app.py. While we could run the application module directly, using Gunicorn via the shell script provides more benefits, such as specifying the number of worker processes and the port. Gunicorn is designed for production environments and offers better performance and flexibility compared to running the app with the default Python server.
- I swapped to an 'appuser'. This is standard security best practice so that if someone got access to the pod they wouldn't have root access on the pod. Running containers as a non-root user helps minimize potential security risks.

### Kubernetes Deployment
- I'm going to use Helm to create deployment manifests 
- Run `helm create helloapp-chart`
- Update the image to use our helloapp image. Since this is local we can just reference the image name.
- Deploy our latest image tag
- Update securityContext protect against root escalation and run pod as non-root user
- Update service to map to port the Docker container is leveraging
- Set some basic requests and then set double the request as the limit before testing performance
- Use port name to map so we don't have to worry about things mapping 

### CI
- I'm going to leverage GitHub Actions for this, it's a common pattern and free to use on public repos
- I want to run our tests in the docker container to make sure we are testing in our production environment, which could surface things like permissions, user, or runtime problems.
- I could just dump all the files into the container but I'd prefer to not have our tests in our production environment so I'll have to modify the Docker image to support this with a multi-stage build.
- Merged my changes into main so that i could test the ci/cd workflow
- This repo is quite old that we cloned from so we have to support master and main for branches
- I want to publish the image so that in theory we could pull it at this point

### CD
- An easy way to only trigger CD on deploy is break these workflows into two files and setting different conditions for each


