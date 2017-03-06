FROM ubuntu:16.04

MAINTAINER Hikaru Wada

# Install Java8 and curl
RUN apt-get update \
  && apt-get install -y openjdk-8-jdk curl

# Download and untar Android SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN curl -L ${ANDROID_SDK_URL} | tar xz -C /usr/local

# Install Android SDK components

ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

ENV ANDROID_COMPONENTS platform-tools,build-tools-25.0.2,android-24,android-25
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository
RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_COMPONENTS}" && \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_COMPONENTS}"

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /pd_build
