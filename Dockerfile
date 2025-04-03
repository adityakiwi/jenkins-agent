FROM eclipse-temurin:17-jdk-jammy

# Create Jenkins user & working dir
RUN useradd -m -d /home/jenkins jenkins
RUN mkdir -p /home/jenkins/agent && chown -R jenkins:jenkins /home/jenkins

# Install tools
RUN apt-get update && \
    apt-get install -y \
    bash \
    curl \
    git \
    docker.io \
    unzip \
    make \
    openssh-client \
    python3-pip && \
    apt-get clean

# Install kubectl (ARM64)
# Install kubectl (ARM64)
RUN curl -LO https://dl.k8s.io/release/v1.29.4/bin/linux/arm64/kubectl && \
    chmod +x kubectl && mv kubectl /usr/local/bin/ && \
    rm -f kubectl
# Install Helm (ARM64)
RUN curl -LO https://get.helm.sh/helm-v3.14.0-linux-arm64.tar.gz && \
    tar -zxvf helm-v3.14.0-linux-arm64.tar.gz && \
    mv linux-arm64/helm /usr/local/bin/helm && \
    rm -rf helm-v3.14.0-linux-arm64.tar.gz linux-arm64

USER jenkins
WORKDIR /home/jenkins/agent

CMD ["sleep", "infinity"]
