<<<<<<< HEAD

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD ["java","-jar","/app/app.jar"]
=======
FROM jenkins/jenkins:lts-jdk17

USER root

<<<<<<< HEAD
# Install required tools
RUN apt-get update && apt-get install -y \
    git curl lsb-release ca-certificates gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install Docker CLI
# Install Docker CLI (stable version)
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Fix Docker permission
RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

USER jenkins

RUN jenkins-plugin-cli --plugins \
    "blueocean docker-workflow kubernetes git pipeline-stage-view"
=======
# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    maven \
    lsb-release \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/keyrings/docker.gpg > /dev/null \
    && echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Switch back to Jenkins user
USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins "docker-workflow kubernetes git pipeline-stage-view workflow-aggregator credentials-binding"
>>>>>>> 4b26e4364165233e3570b0ec26aff8a6c542169c
>>>>>>> 93ca08d5abebadf12d0466e9657c4732570e8a2a
