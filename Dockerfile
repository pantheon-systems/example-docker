FROM quay.io/getpantheon/alpine:3.14-curl

# configure environment
ENV BASEDIR /opt/example-docker
ENV PACKAGE='python3'
ENV DOWNLOAD_PACKAGE='py-pip python3-dev build-base'

# apk install
RUN apk update --no-cache && \
    apk add --no-cache ${PACKAGE} && \
    apk add --no-cache ${DOWNLOAD_PACKAGE} -t buildpack && \
    rm -rf /var/cache/apk/*

# pip install
RUN pip install --upgrade pip && \
    pip install flask

# clean up
RUN apk del --no-cache buildpack && \
    rm -rf /var/cache/apk/*

# cloning is conditional to allow us to mount a local clone for local development
COPY . $BASEDIR
WORKDIR $BASEDIR

# run app
ENTRYPOINT ["python3"]
CMD ["app.py"]
