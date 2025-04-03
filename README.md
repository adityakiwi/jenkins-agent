# Secure Jenkins Agent (ARM64)

This is a custom Jenkins agent Docker image built for ARM64 with tools for modern DevSecOps pipelines.

## Includes

- OpenJDK 17 (Temurin)
- Docker CLI
- `kubectl` (v1.29.4)
- Helm (v3.14.0)
- Trivy (vulnerability scanner)
- Kyverno CLI (policy validation)
- Git, curl, unzip, make, Python 3

## Usage

### Build the Image

```bash
docker build -t adidix/jenkins-agent-k8s:secure .
