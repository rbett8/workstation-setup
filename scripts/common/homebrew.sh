echo

# hash returns recently run programs, if program is not found std err is discared by way of /dev/null and if fails
if hash brew 2>/dev/null; then
  echo "Homebrew is already installed!"
else
  echo "Installing Homebrew..."

  # the `yes` command here outputs `y` until the command is interuptted
  # it is used here to answer in the affirmative for this interactive script
  yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if which brew; then
      echo "Homebrew install verified"
  else
      echo "Adding Homebrew to your PATH"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo
echo "Ensuring you have the latest Homebrew..."
brew update

echo
echo "Ensuring your Homebrew directory is writable..."
sudo chown -Rf $(whoami) $(brew --prefix)/*

echo
echo "Installing Homebrew services..."
brew tap homebrew/services

# echo
# echo "Adding Pivotal tap to Homebrew"
# brew tap pivotal/tap

echo "Cleaning up your Homebrew installation..."
brew cleanup
