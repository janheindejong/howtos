#!/usr/bin/env bash
# Run this ON the Raspberry Pi (e.g. over SSH):  bash pi-zsh-setup.sh
# Installs: zsh, oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting, fzf, eza
# Safe to re-run. Your existing ~/.zshrc is backed up first.
set -euo pipefail

say() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

install_eza_release() {
  local target tmp
  case "$(uname -m)" in
    aarch64|arm64) target=aarch64-unknown-linux-gnu ;;
    armv7l|armv6l) target=arm-unknown-linux-gnueabihf ;;
    x86_64)        target=x86_64-unknown-linux-gnu ;;
    *) echo "No prebuilt eza for $(uname -m)"; return 1 ;;
  esac
  tmp=$(mktemp -d)
  curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_${target}.tar.gz" \
    | tar -xz -C "$tmp"
  sudo install -m 0755 "$tmp/eza" /usr/local/bin/eza
  rm -rf "$tmp"
}

say "Installing packages (zsh, git, curl, fzf)"
sudo apt-get update
sudo apt-get install -y zsh git curl fzf

say "Installing eza"
if ! command -v eza >/dev/null 2>&1; then
  # In apt on Debian 13+/Ubuntu 24.04+; not on Raspberry Pi OS Bookworm
  sudo apt-get install -y eza 2>/dev/null || install_eza_release \
    || echo "WARNING: eza not installed; aliases will fall back to plain ls"
fi

say "Installing oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

say "Installing plugins"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone() { [ -d "$2" ] || git clone --depth=1 "$1" "$2"; }
clone https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

say "Writing ~/.zshrc"
if [ -f "$HOME/.zshrc" ]; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y%m%d-%H%M%S)"
fi

cat > "$HOME/.zshrc" <<'EOF'
# ---- oh-my-zsh ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode disabled        # no update checks on every login (slow on a Pi)
DISABLE_UNTRACKED_FILES_DIRTY="true"      # faster git prompt in big repos

# zsh-syntax-highlighting must stay last
plugins=(git sudo extract colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# ---- prompt: show hostname when connected over SSH, so you know you're on the Pi ----
if [[ -n "$SSH_CONNECTION" ]]; then
  PROMPT="%F{yellow}%n@%m%f $PROMPT"
fi

# ---- history ----
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY

# ---- autosuggestions ----
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept           # Ctrl+Space accepts the suggestion

# ---- fzf (Ctrl+R history, Ctrl+T files, Alt+C cd) ----
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
if fzf --zsh >/dev/null 2>&1; then        # fzf >= 0.48
  source <(fzf --zsh)
else                                      # older apt version (Raspberry Pi OS Bookworm)
  for f in /usr/share/doc/fzf/examples/key-bindings.zsh /usr/share/doc/fzf/examples/completion.zsh; do
    [ -f "$f" ] && source "$f"
  done
fi

# ---- eza ----
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --git --group-directories-first'
  alias la='eza -lah --icons --git --group-directories-first'
  alias lt='eza --tree --level=2 --icons'
fi

# ---- misc ----
export EDITOR=nano
export PATH="$HOME/.local/bin:$PATH"
EOF

say "Setting zsh as default shell"
sudo chsh -s "$(command -v zsh)" "$USER"

say "Done. Log out and back in (or run: exec zsh)"
