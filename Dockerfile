# Use official Python image
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make sure run.sh is executable
RUN chmod +x run.sh

# Create a non-root user and switch to it
RUN useradd --create-home appuser \
	&& chown -R appuser /app
USER appuser

# Set entrypoint to run.sh
CMD ["/app/run.sh"]
