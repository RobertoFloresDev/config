# Git User Global Configuration
git config --global user.email "first.last@example.com"
git config --global user.name "First Last"
git config --global core.editor "nano"
## Git user local configuration (for a specific repository)
git config user.email "first.last@example.com"
git config user.name "First Last"
## Lisc configuration
git config -l

# Git generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"
## Legaciy system (use RSA instead)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"