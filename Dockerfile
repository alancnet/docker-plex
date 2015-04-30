FROM phusion/baseimage:0.9.15

ENV DEBIAN_FRONTEND noninteractive

ENV HOME /root

VOLUME /mnt/plex_config
VOLUME /mnt/array1/Public
VOLUME /mnt/array2/Public

RUN ln -s -f /bin/true /usr/bin/chfn && \
	apt-get -q update && \
	apt-get install -qy gdebi-core wget && \
	installplex.sh / && \
	bash /installplex.sh && \
	usermod -u 999 plex && \
	usermod -g 100 plex && \
	mkdir -p /etc/my_init.d && \
	mkdir /etc/service/plex

ADD plexmediaserver /etc/default/plexmediaserver
ADD firstrun.sh /etc/my_init.d/firstrun.sh
ADD plex.sh /etc/service/plex/run

RUN chmod +x /etc/my_init.d/firstrun.sh && \
	chmod +x /etc/service/plex/run

CMD ["/sbin/my_init"]

EXPOSE 32400