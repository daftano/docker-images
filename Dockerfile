FROM daftano/ubuntu:16.04
LABEL maintainer="Davide Fiorentino lo Regio"
LABEL maintainer-twitter"@daftano"

ARG JAVA_VERSION=8
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oracle

ENTRYPOINT ["/usr/bin/java"]
CMD ["-version"]

RUN \
  echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && add-apt-repository -y ppa:webupd8team/java \
  && apt-get update \
  && apt-get install -qqy --no-install-recommends oracle-java${JAVA_VERSION}-installer oracle-java${JAVA_VERSION}-set-default \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/oracle-jdk${JAVA_VERSION}-installer

ADD ["./jce-policy/${JAVA_VERSION}/*.jar", "/usr/lib/jvm/java-${JAVA_VERSION}-oracle/jre/lib/security/"]
