# Claude Code Loop - Autonomous AI Coding

Containerized Claude Code automation system for running Claude Code in continuous loops.

## Credits

This implementation is inspired by and based on the concepts from:
- [Claude Code on Loop: Autonomous AI Coding](https://mfyz.com/claude-code-on-loop-autonomous-ai-coding/) by mfyz

## Usage instructions
```shell
# Build image
docker build -t claude-loop:v1 .

# On host, prepare directories
mkdir -p ./workspace ./logs
# Put your prompt.md into ./workspace

# Create a long-lived OAuth token (do this once)
claude setup-token

export CLAUDE_CODE_OAUTH_TOKEN=<token>

# This will start the non-interactive loop.
# You can keep the implementation planning separate by mounting /plans read-only.
# This way you nicely separate planning from implementation and potentially have multiple
# implementations based on the same plan.
docker run -it \
  --user $(id -u):$(id -g) \
  -e HOME=/workspace \
  -e CLAUDE_CODE_OAUTH_TOKEN="$CLAUDE_CODE_OAUTH_TOKEN" \
  -v "$(pwd)/logs:/logs" \
  -v "$(pwd)/workspace:/workspace" \
  -v "/Users/me/myprojects/new-project/plans:/workspace/plans:ro" \
  claude-loop:v1
```

Once done, the loop begins writing to /logs/loop.log which you can tail from host:
```shell
  tail -f ./logs/loop.log
```
