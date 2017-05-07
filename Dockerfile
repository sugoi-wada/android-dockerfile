FROM ubuntu:16.04

MAINTAINER Hikaru Wada

# Install Utilities
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk curl wget unzip git locales

# Locale settings
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

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
    echo y | sdkmanager "build-tools;25.0.2" && \
    echo y | sdkmanager "build-tools;25.0.3" && \
    echo y | sdkmanager "platforms;android-24" && \
    echo y | sdkmanager "platforms;android-25" && \
    echo y | sdkmanager "add-ons;addon-google_apis-google-24"

# clean 

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /pd_build
