FROM ruby:2.5.1-alpine
MAINTAINER Hikaru Wada

# Install Utilities
RUN apk update && \
    apk upgrade && \
    apk --no-cache add \
     openjdk8 curl wget unzip git bash make gcc musl-dev openssh-client openssl

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV ANDROID_HOME /usr/local/android-sdk-linux

# Download and unzip Android SDK

RUN cd /usr/local && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O android-sdk.zip && \
    unzip android-sdk.zip -d android-sdk-linux && \
    rm -f android-sdk.zip

ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin

# Install Android SDK components

RUN echo y | sdkmanager --update && \
    echo y | sdkmanager "platform-tools" && \
    echo y | sdkmanager "extras;android;m2repository" && \
    echo y | sdkmanager "extras;google;m2repository" && \
    echo y | sdkmanager "extras;google;google_play_services" && \
    echo y | sdkmanager "platforms;android-26" && \
    echo y | sdkmanager "platforms;android-27"

