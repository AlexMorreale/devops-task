# Stage 1: Base image with dependencies
FROM python:3.13-slim as base

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Test stage - includes test files
FROM base as test

# Copy all files including tests
COPY . .

# Don't run tests during build - we'll run them separately

# Stage 3: Production stage - clean image without tests
FROM base as production

# Copy only application files (no tests)
COPY helloapp/ ./helloapp/
COPY run.sh .

# Make sure run.sh is executable
RUN chmod +x run.sh

# Create a non-root user and switch to it
RUN useradd --create-home appuser \
	&& chown -R appuser /app
USER appuser

# Set entrypoint to run.sh
CMD ["/app/run.sh"]
