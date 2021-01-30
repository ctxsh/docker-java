FROM ctxsh/core:v1.3 as extract

ARG URL

WORKDIR /output
RUN : \
    && mkdir -p opt/java \
    && curl -sL $URL | tar zxf - -C opt/java --strip-components=1 \
    && :

FROM ctxsh/core:v1.3

ENV LANG C.UTF-8
ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$PATH

COPY --from=extract /output /

CMD ["/bin/bash"]