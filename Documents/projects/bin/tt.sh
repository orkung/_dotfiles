#! /bin/bash

# put the search string into the search file
search_file=".task/task-pane-search"
refresh_file=".task/task-pane-refresh"
if [ $# -gt 0 ]; then
    echo "${@}" > $search_file
fi

# start the task pane up if it doesn't exist
task_pane=$(readlink -f ~/bin/task-pane.sh)
matching_pane=$(tmux list-panes -F "#{pane_id} #{pane_start_command}" | grep "^%[0-9]* $task_pane$" | cut -d' ' -f 1)
if [ -z "$matching_pane" ]; then
    tmux split-window -p 40 -vbd ~/bin/task-pane.sh
else
    date > $refresh_file
fi
