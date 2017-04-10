# Static Page Publisher for Domain Message Specs

A simple nginx container, and a second container to pull static content from git for publication in the nginx container.

Now, build an nginx container to serve up the pages
```
./deploy-nginx.sh
```

Now, build the publisher image:

```
./buildPublisher.sh
```

Now, create a directory to hold your html content:

```
mkdir -p /docker-data/static-pages
chown -R 1000:1000 /docker-data/static-pages
```

Note: If you are using user namespacing in your docker daemon (recommended on live systems), then the user id above will differ.

## Bulk DMSs (e.g. those held in "other-messaging-specs" repository)

Use your docker image to generate the pages into a target path which can be served up using nginx

```
./publish.sh "" "" https://github.com/nhsconnect/other-messaging-specs master dms fhir
```

Note: The above steps assume we are not using a private registry, and that we are interacting with the local docker daemon. Additional parameters can be used for a private registry and remote docker daemons (via the ReST API).

Now you should be able to open the pages in your browser: http://localhost:8082/

## Single DMSs (e.g. repositories holding a single DMS with source and generated pages - e.g. NHS-CDS-eDischarge)

The process for these DMSs is very similar, but uses a slightly different script to allow the "Generated" directory to map to a different directory name when published.

Use your docker image to generate the pages into a target path which can be served up using nginx

```
./publish-single-DMS.sh "" "" https://github.com/nhsconnect/NHS-CDA-eDischarge.git gh-pages Generated NHS-CDA-eDischarge
```

Note: The above steps assume we are not using a private registry, and that we are interacting with the local docker daemon. Additional parameters can be used for a private registry and remote docker daemons (via the ReST API).

Now you should be able to open the pages in your browser: http://localhost:8082/specifications/NHS-CDA-eDischarge/
