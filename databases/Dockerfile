FROM ubuntu:16.04
MAINTAINER Łukasz Piłatowski <lpilatowski@teonite.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl apt-transport-https locales

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

ENV ACCEPT_EULA Y

RUN apt-get update && apt-get install -y mssql-tools unixodbc-dev

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /sql

COPY *.sql ./

COPY entrypoint.sh .

CMD "/sql/entrypoint.sh"
