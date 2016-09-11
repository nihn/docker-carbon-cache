FROM carbon

MAINTAINER mateuszmoneta@gmail.com

ENV MAX_UPDATES_PER_SECOND=500\
    MAX_CREATES_PER_MINUTE=50

VOLUME $GRAPHITE_STORAGE_DIR

EXPOSE 2003 2004

ENTRYPOINT ["/carbon-entrypoint.py", "carbon-cache.py"]
