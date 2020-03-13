#!/bin/bash

main="$1"

cd "$(dirname "$0")" || exit $?

# in-process sleep so we stay killable
sleep() {
    [[ -n "${_sleep_fd:-}" ]] || exec {_sleep_fd}<> >(:)
    read -t "$1" -u $_sleep_fd || :
}

# wait for the db to come up
while ! echo >/dev/tcp/postgres/5432; do
    echo "keystone ($main) waiting for postgres"
    sleep 1
done

# main
if [ "$main" = 'init' ]; then
    npm init keystone-app app && touch initialized
else
    # wait for keystone initialization
    while [ ! -f initialized ]; do
        echo "keystone ($main) waiting for keystone initialization"
        sleep 5
    done
    cd app || exit $?

    exec npm run dev
fi

