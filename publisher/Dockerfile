FROM ubuntu:16.04

# Add git
RUN apt-get update && apt-get install -y git

# Create a new user for the rest
RUN groupadd -r generator -g 1000 && \
    useradd -u 1000 -s /bin/bash -r -g generator generator

# Copy in entrypoint scripts
COPY entrypoint.sh /entrypoint.sh
COPY entrypoint-single-dms.sh /entrypoint-single-dms.sh
RUN chmod +x entrypoint.sh
RUN chmod +x entrypoint-single-dms.sh

VOLUME ["/content"]

# We will run the generator as a non-root user
USER generator

ENTRYPOINT ["/entrypoint.sh", "/entrypoint-single-dms.sh"]

