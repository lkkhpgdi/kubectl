FROM alpine:3.6

LABEL MAINTAINER digital.innovation@infinitus-int.com

ENV KUBE_LATEST_VERSION="v1.19.0"
ENV HOME=/config

RUN apk update && apk upgrade \
 && apk add bash jq gettext libintl \
 && apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

RUN  adduser kubectl -Du 2342 -h /config 

USER kubectl

CMD ["/usr/local/bin/kubectl", "help"]
