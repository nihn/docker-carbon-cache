# docker-carbon-cache #
Minimal image based on `python:2.7.12-alpine` with carbon-cache daemon running.

## Base usage ##
```
docker run -p 2003:2003 -p 2004:2004 mateuszm/carbon-cache
```

## Configuration ##
You can configure all settings via environment variables prefixed with
"CARBON_OPT_".
You can also just create your own image and copy configuration into it:

```
COPY carbon.conf $GRAPHITE_CONF_DIR/carbon.conf
```
or mount it into container.

Config files (Everything in $GRAPHITE_CONF_DIR) are formated by image's 
entrypoint with environment as keys, so you can dynamically change it's contents
by using environment variables in braces, e.g:

```
MAX_CREATES_PER_MINUTE = {MAX_CREATES_PER_MINUTE}
```

You can also pass additional options to carbon binary via `CARBON_OPTS` env:
```
docker run -e CARBON_OPTS="--instance cache-x" -p 2003:2003 -p 2004:2004 mateuszm/carbon-cache
```

## Base compose file to run minimal graphite stack ##

```yaml
version: '2'

services:
   cache:
       image: mateuszm/carbon-cache
       volumes:
         - storage:/var/lib/carbon/whisper
   web:
       image: mateuszm/graphite-web
       ports:
          - 80:8000
       volumes:
          - storage:/var/lib/carbon/whisper

volumes:
    storage:
        driver: local
```
