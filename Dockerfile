# Dockerfile
FROM ubuntu:22.04

# install base dependencies and Node.js LTS
RUN apt-get update && apt-get install -y \
    curl git jq figlet figlet-fonts build-essential bash-completion \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get update && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

# create non-root user and directories
#RUN useradd --create-home --shell /bin/bash claudeuser \
#  && mkdir /workspace /logs \
#  && chown claudeuser:claudeuser /workspace /logs

RUN mkdir /workspace /logs

WORKDIR /workspace 

# install Claude Code globally via npm
RUN npm install -g @anthropic-ai/claude-code

# copy supporting scripts
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

VOLUME ["/logs"]
ENTRYPOINT [ "/usr/local/bin/start.sh" ]