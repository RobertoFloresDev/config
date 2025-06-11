# Config MacOS

## Turn on sharing

- Settings > General > Sharing > Screen Sharing
- Settings > General > Sharing > Remote Login

## Turn on Automatic login

- Settings > Users & Groups > Automatically log in as (user)

## Turn on Automatic Start on power failure

- Settings > Energy > Start up automatically after power failure

## Install [Ollama](https://ollama.com/download)

### After install

- Settings > General > Login Items & Extensions > Ollama in open at login

### External access Ollama
```bash
launchctl setenv OLLAMA_HOST "0.0.0.0"
launchctl setenv OLLAMA_ORIGINS "*"
```

## Install Tailscale

### After install verify

- Settings > General > Allow in the background (Tailscale on, if not click on Network Extensions and turn on first)


## Test Ollama externally

```bash
curl http://sub.example.com:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "why the sky is blue?",
  "format": "json",
  "stream": false
}'
```