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
