#
# Globes primary nameserver DNS tables compilation makefile
#

# makezones script
MAKEZONES = /etc/named/makezones-0.10

# automatically take all source-files
ALL = $(patsubst %.source,primary/%,$(wildcard *.source))

# build everything and restart named
all : $(ALL)
	kill -HUP `cat /var/run/named.pid`

# implicit rules for all tables
primary/% : %.source
	$(MAKEZONES) $^ $(patsubst %.source,%,$^) $@

# xpert.com table 
primary/xpert.com: xpert.com.source
	$(MAKEZONES) xpert.com.source xpert.com primary/xpert.com primary/db.199.203.132

# cleaning rule
clean:
	rm -f primary/*
	cp localhost-rev primary/

