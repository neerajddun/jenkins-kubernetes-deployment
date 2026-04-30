FROM jenkins/jenkins:2.479.3-jdk17
USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    lsb-release \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg

# Install Docker CLI
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli

# Install kubectl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | \
    gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
    https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" > \
    /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && apt-get install -y kubectl

USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins blueocean docker-workflow kubernetes kubernetes-cli git workflow-aggregator credentials-binding