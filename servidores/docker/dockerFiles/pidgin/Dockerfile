FROM alpine

RUN apk add --no-cache --update pidgin ghostscript-fonts

RUN adduser -h /home/pidgin -u 1000 -D pidgin

USER pidgin

#ENTRYPOINT [ "pidgin" ]

#CMD [ "-c", "/home/pidgin/config" ]

# To run
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix pidgin