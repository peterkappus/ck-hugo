
# kill child processes (e.g. pug)
# credit: https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT


#render pug files into html
pug -w themes/carolkappus/layouts &

#serve site
docker compose up
