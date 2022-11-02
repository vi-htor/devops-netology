FROM centos:7

RUN cd /opt && \
    groupadd elastic && \
    useradd -r -g elastic elastic && \
    yum -y install wget perl-Digest-SHA && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.0-linux-aarch64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.0-linux-aarch64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-8.5.0-linux-aarch64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.5.0-linux-aarch64.tar.gz && \
        rm elasticsearch-8.5.0-linux-aarch64.tar.gz elasticsearch-8.5.0-linux-aarch64.tar.gz.sha512 && \
        mkdir /var/lib/data && chmod -R 777 /var/lib/data && \
        chown -R elastic:elastic /opt/elasticsearch-8.5.0 && \
	    yum -y remove wget perl-Digest-SHA && \
	    yum clean all

USER elastic
WORKDIR /opt/elasticsearch-8.5.0/
COPY elasticsearch.yml  config/
EXPOSE 9200
ENTRYPOINT ["bin/elasticsearch"]