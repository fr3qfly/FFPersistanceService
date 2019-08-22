FROM swift:lastest as builder
WORKDIR /root

LABEL "com.github.actions.name"="Hello World"
LABEL "com.github.actions.description"="Write args to standard output"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/fr3qfly/FFPersistanceService"
LABEL "homepage"="https://github.com/fr3qfly/"
LABEL "maintainer"="BalazsSzamody"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]