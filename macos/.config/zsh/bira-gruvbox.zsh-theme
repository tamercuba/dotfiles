local return_code="%(?..%F{#ea6962}%? ↵%f)"
local user_host="%B%(!.%F{#ea6962}.%F{#a9b665})%n@%m%f "
local user_symbol='%(!.#.$)'
local current_dir="%B%F{#7daea3}%~ %f"
local conda_prompt='$(conda_prompt_info)'

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
    local kube_prompt='$(kube_ps1)'
else
    local kube_prompt=''
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}${kube_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{#d8a657}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{#ea6962}●%F{#d8a657}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{#d8a657}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%F{#ea6962}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %f"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%F{#a9b665}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %f"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
