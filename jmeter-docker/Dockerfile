FROM alpine:3.15

ARG JMETER_VERSION="5.6.3"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV MIRROR_HOST http://mirrors.ocf.berkeley.edu/apache/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL http://repo1.maven.org/maven2/kg/apc
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/
ENV PATH $PATH:$JMETER_BIN

# Install dependencies and JMeter
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        openjdk8-jre \
        curl \
        bash \
        unzip \
        tzdata \
        ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Rome /etc/localtime && \
    echo "Europe/Rome" > /etc/timezone && \
    update-ca-certificates && \
    mkdir -p /tmp/dependencies && \
    curl -L --silent ${JMETER_DOWNLOAD_URL} -o /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt && \
    tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm -rf /tmp/dependencies

# Optional: Download plugins (uncomment if needed)
# RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-dummy-0.2.jar
# RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-cmn-jmeter/0.5/jmeter-plugins-cmn-jmeter-0.5.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-cmn-jmeter-0.5.jar

WORKDIR ${JMETER_HOME}

CMD ["tail", "-f", "/dev/null"]