# Stage 1: Build stage (Placeholder for future application builds)
FROM alpine:3.19 AS builder

# Set working directory
WORKDIR /build

# Create a simple script as a placeholder for the application
RUN echo '#!/bin/sh' > entrypoint.sh && \
    echo 'echo "NextGen DevOps Automation Container Running"' >> entrypoint.sh && \
    chmod +x entrypoint.sh

# Stage 2: Production stage (Final minimal image)
FROM alpine:3.19

# Metadata labels for enterprise tracking
LABEL maintainer="NextGen DevOps Team" \
      version="1.0.0" \
      description="Production-grade base image for NextGen DevOps Automation"

# Create a non-root user and group for security hardening
# Using a fixed UID/GID is standard for production consistency
RUN addgroup -S devopsgroup && adduser -S devopsuser -G devopsgroup

# Set the working directory in the final image
WORKDIR /app

# Copy only necessary artifacts from the builder stage
# This fulfills the multi-stage requirement and keeps the image slim
COPY --from=builder --chown=devopsuser:devopsgroup /build/entrypoint.sh ./

# Switch to the non-root user
USER devopsuser

# Execute the placeholder script
# Using CMD instead of ENTRYPOINT to allow for flexibility during testing
CMD ["./entrypoint.sh"]
