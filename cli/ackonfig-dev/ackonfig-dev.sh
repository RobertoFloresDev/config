#!/bin/sh

# Function to echo text incolor
echo_red() {
  echo "\e[38;5;196m$1\e[0m"
}
echo_orange() {
  echo "\e[38;5;214m$1\e[0m"
}
echo_yellow() {
  echo "\e[38;5;226m$1\e[0m"
}
echo_green() {
  echo "\e[38;5;46m$1\e[0m"
}
echo_blue() {
  echo "\e[38;5;39m$1\e[0m"
}
echo_purple() {
  echo "\e[38;5;129m$1\e[0m"
}

# Function to set up Git global username and email
set_git_global_configuration() {
  if [ "$#" -eq 2 ]; then
    git_username="$1"
    git_email="$2"
    git_editor="$3"
  else
    read -p "Enter your Git username: " git_username
    read -p "Enter your Git email: " git_email
    read -p "Enter your Git email: " git_editor
  fi
  git config --global user.name "$git_username"
  git config --global user.email "$git_email"
  git config --global core.editor "$git_editor"
  echo_blue "Git username, email and editor have been configured successfully.\n"
}

# Function to set up Git local username and email
set_git_local_configuration() {
  if [ "$#" -eq 2 ]; then
    git_username="$1"
    git_email="$2"
  else
    read -p "Enter your Git username for this repository: " git_username
    read -p "Enter your Git email for this repository: " git_email
  fi
  git config user.name "$git_username"
  git config user.email "$git_email"
  echo_blue "Git username and email for this repository have been configured successfully.\n"
}

# Function to set primary prompt with Git branch
set_bashrc_config() {
  if ! grep -Fxq "source $(dirname "$(realpath "$0")")/install/.bashrc" ~/.bashrc; then
    echo "source $(dirname "$(realpath "$0")")/install/.bashrc" >> ~/.bashrc
    echo_blue "bashrc configuration has been set successfully."
    echo_purple "Please restart your terminal or run 'source ~/.bashrc' to apply the changes.\n"
  else
    echo_orange "The configuration is already present in ~/.bashrc.\n"
  fi
}

# Function to change user password (see if this works or if it's required something different)
# change_user_password() {
#   if [ "$#" -eq 2 ]; then
#     username="$1"
#     password="$2"
#   else
#     read -p "Enter the username: " username
#     read -sp "Enter the new password: " password
#   fi
#   echo "$username:$password" | chpasswd
#   echo_blue "Password for user $username has been changed successfully.\n"
# }

# Function to ask password when sudo
# ask_sudo_password() {
#   echo_red "Please enter your password to proceed with the installation.\n"
# }

# Check for command-line arguments
if [ "$#" -gt 0 ]; then
  case $1 in
    set-git-global)
      if [ "$#" -eq 4 ]; then
        set_git_global_configuration "$2" "$3" "$4"
      else
        set_git_global_configuration
      fi
      exit 0
      ;;
    set-git-local)
      if [ "$#" -eq 3 ]; then
        set_git_local_configuration "$2" "$3"
      else
        set_git_local_configuration
      fi
      exit 0
      ;;
    set-bashrc)
      set_bashrc_config
      exit 0
      ;;
    # change-password)
    #   if [ "$#" -eq 3 ]; then
    #     change_user_password "$2" "$3"
    #   else
    #     change_user_password
    #   fi
    #   exit 0
    #   ;;
    # ask-sudo-password)
    #   ask_sudo_password
    #   exit 0
    #   ;;
    *)
      echo "Invalid argument. Available options are:"
      echo "  set-git-global [username] [email] [editor]  - Configure Git username and email"
      echo "  set-git-local [username] [email]            - Configure local Git username and email"
      echo "  set-bashrc                                  - Configure bashrc"
      # echo "  change-password [username] [password]       - Change user password"
      # echo "  ask-sudo-password                           - Ask for sudo password"
      exit 1
      ;;
  esac
fi

# Menu loop
while true; do
  echo "Menu:"
  echo "1. Set Git global configuration"
  echo "2. Set Git local configuration"
  echo "3. Set bashrc configuration"
  # echo "4. Change user password"
  # echo "5. Ask for sudo password"
  echo "q. Exit"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      set_git_global_configuration
      ;;
    2)
      set_git_local_configuration
      ;;
    3)
      set_bashrc_config
      ;;
    # 4)
    #   change_user_password
    #   ;;
    # 5)
    #   ask_sudo_password
    #   ;;
    q)
      echo_green "Exiting..."
      break
      ;;
    *)
      echo_red "Invalid choice. Please try again.\n"
      ;;
  esac
done