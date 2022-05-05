FROM debian:bullseye

ENV LANG C.UTF-8

# update system 
RUN apt-get update && apt-get install -y wget unzip

RUN wget -o https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots -O /tmp/chrome.zip 

RUN unzip /tmp/chrome.zip