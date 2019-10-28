#/usr/bin/env bash
_lum_completions()
{
    local command="${COMP_WORDS[1]}"
    local commands=("commit" "help" "init" "ldoc" "license" "npminit" "project" "push" "release" "run")
    if [ -z command ] ; then
        COMPREPLY=($(compgen -W "commit help init ldoc license npminit project push release run" "command"))
    else
        if [ "${#COMP_WORDS[@]}" != "1" ] ; then
            COMPREPLY=($(compgen -W "commit help init ldoc license npminit project push release run" "$command"))
        # else
            # case $COMP_WORDS[2] in
            #     commit)
            #         ;;
            # esac
        fi
    fi
    
}

complete -F _lum_completions lum
