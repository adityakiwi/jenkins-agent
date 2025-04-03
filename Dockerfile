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
    python3-pip \
    gnupg \
    lsb-release \
    ca-certificates && \
    apt-get clean

# Install kubectl (ARM64)
RUN curl -LO https://dl.k8s.io/release/v1.29.4/bin/linux/arm64/kubectl && \
    chmod +x kubectl && mv kubectl /usr/local/bin/

# Install Helm (ARM64)
RUN curl -LO https://get.helm.sh/helm-v3.14.0-linux-arm64.tar.gz && \
    tar -zxvf helm-v3.14.0-linux-arm64.tar.gz && \
    mv linux-arm64/helm /usr/local/bin/helm && \
    rm -rf helm-v3.14.0-linux-arm64.tar.gz linux-arm64

# Install Trivy (ARM64)
RUN wget https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.50.1_Linux-ARM64.tar.gz && \
    tar -xvzf trivy_0.50.1_Linux-ARM64.tar.gz && \
    mv trivy /usr/local/bin/ && \
    rm -rf trivy_0.50.1_Linux-ARM64.tar.gz

# Install Kyverno CLI (ARM64)
RUN curl -LO https://github.com/kyverno/kyverno/releases/latest/download/kyverno-cli_linux_arm64.tar.gz && \
    tar -xvzf kyverno-cli_linux_arm64.tar.gz && \
    mv kyverno /usr/local/bin/ && \
    rm -rf kyverno-cli_linux_arm64.tar.gz

USER jenkins
WORKDIR /home/jenkins/agent

CMD ["sleep", "infinity"]
