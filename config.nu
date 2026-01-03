# Configuration Nushell propre et moderne
# À placer dans ~/.config/nushell/config.nu
# ============================================================================
# CONFIGURATION GÉNÉRALE
# ============================================================================
$env.config = {
  show_banner: false
  
  # Éditeur par défaut
  buffer_editor: "nvim"
  
  # Comportement du shell
  use_ansi_coloring: true
  edit_mode: emacs  # ou "vi" si vous préférez
  shell_integration: {
    osc2: true
    osc7: true
    osc8: true
    osc9_9: false
    osc133: true
    osc633: true
    reset_application_mode: true
  }
  
  # Complétion
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 100
      completer: null
    }
  }
  
  # Historique
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: false
  }
  
  # Curseur
  cursor_shape: {
    emacs: line
    vi_insert: line
    vi_normal: block
  }
  
  # Couleurs et thème
  color_config: {
    separator: white
    leading_trailing_space_bg: { attr: n }
    header: green_bold
    empty: blue
    bool: white
    int: white
    filesize: cyan
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: { bg: red fg: white }
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_garbage: { fg: white bg: red attr: b }
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
  }
  
  # Keybindings
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: [emacs, vi_insert, vi_normal]
      event: { send: menu name: history_menu }
    }
    {
      name: clear_screen
      modifier: control
      keycode: char_l
      mode: [emacs, vi_insert, vi_normal]
      event: { send: clearscreen }
    }
  ]
  
  # Menus
  menus: [
    {
      name: completion_menu
      only_buffer_difference: false
      marker: "| "
      type: {
        layout: columnar
        columns: 4
        col_width: 20
        col_padding: 2
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
    {
      name: history_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: list
        page_size: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
  ]
  
  # Hooks
  hooks: {
    pre_prompt: [{ null }]
    pre_execution: [{ null }]
    env_change: {
      PWD: [{|before, after| null }]
    }
    display_output: "if (term size).columns >= 100 { table -e } else { table }"
  }
  
  # Performance
  table: {
    mode: rounded
    index_mode: always
    show_empty: true
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: "..."
    }
  }
  
  explore: {
    help_banner: true
    exit_esc: true
    command_bar_text: '#C4C9C6'
    status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6'}
    highlight: {bg: 'yellow' fg: 'black'}
    table: {
      split_line: '#404040'
      cursor: true
      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true
      show_head: true
      show_index: true
    }
  }
}

# ============================================================================
# COMPATIBILITÉ LINUX - Commandes de base
# ============================================================================
# Utilisation des commandes externes Linux natives (préfixe ^)
alias cat = ^cat
alias grep = ^grep
alias find = ^find
alias sed = ^sed
alias awk = ^awk
alias head = ^head
alias tail = ^tail
alias cut = ^cut
alias sort = ^sort
alias uniq = ^uniq
alias wc = ^wc
alias tr = ^tr
alias diff = ^diff
alias less = ^less
alias more = ^more
alias nano = ^nano
alias vim = ^vim
alias nvim = ^nvim
alias top = ^top
alias htop = ^htop
alias ps = ^ps
alias kill = ^kill
alias chmod = ^chmod
alias chown = ^chown
alias cp = ^cp
alias mv = ^mv
alias rm = ^rm
alias mkdir = ^mkdir
alias rmdir = ^rmdir
alias touch = ^touch
alias ln = ^ln
alias tar = ^tar
alias zip = ^zip
alias unzip = ^unzip
alias curl = ^curl
alias wget = ^wget
alias ssh = ^ssh
alias scp = ^scp
alias rsync = ^rsync
alias df = ^df
alias du = ^du
alias free = ^free
alias man = ^man
alias which = ^which
alias whereis = ^whereis

# ============================================================================
# ALIASES UTILES
# ============================================================================
# Navigation rapide
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias l = ls -la
alias ll = ls -l
alias la = ls -a

# Git
alias g = git
alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gl = git log --oneline --graph --decorate
alias gd = git diff
alias gco = git checkout
alias gb = git branch
alias gpl = git pull

# Outils système
alias c = clear
alias h = history
alias q = exit

# ============================================================================
# FONCTIONS PERSONNALISÉES
# ============================================================================
# Créer un répertoire et y naviguer
def mkcd [name: string] {
  mkdir $name
  cd $name
}

# Recherche rapide dans l'historique
def hs [pattern: string] {
  history | where command =~ $pattern | select command
}

# Taille du répertoire actuel
def dirsize [] {
  ls | get size | math sum
}

# Extraction d'archives
def extract [file: path] {
  match ($file | path parse | get extension) {
    "zip" => { ^unzip $file },
    "tar" => { ^tar -xf $file },
    "gz" => { ^tar -xzf $file },
    "bz2" => { ^tar -xjf $file },
    "xz" => { ^tar -xJf $file },
    _ => { print $"Format non supporté: ($file)" }
  }
}

# Recherche de fichiers par nom
def ff [pattern: string] {
  ^find . -iname $"*($pattern)*"
}

# Recherche dans les fichiers
def search [pattern: string] {
  ^grep -r $pattern .
}

# Taille des dossiers dans le répertoire courant
def sizes [] {
  ^du -sh * | sort -h
}

# ============================================================================
# PROMPT PERSONNALISÉ
# ============================================================================
# Prompt avec utilisateur@hostname:chemin (chemin complet sans ~)
def create_left_prompt [] {
    let path_segment = $env.PWD
    let user = (whoami)
    let hostname = (hostname | str trim)
    
    $"(ansi green_bold)($user)@($hostname)(ansi reset):(ansi blue_bold)($path_segment)(ansi reset) (ansi yellow)❯(ansi reset) "
}

$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# ============================================================================
# VARIABLES D'ENVIRONNEMENT
# ============================================================================
# Éditeurs
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Ajoutez vos variables d'environnement personnalisées ici
