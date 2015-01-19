# installation /build-process

## eccenca/baseimage_docker
```
git clone https://github.com/eccenca/baseimage-docker.git
cd baseimage-docker/image
docker build -t registry.docker.eccenca.com/baseimage:latest .
```

## eccenca/ckan
```
git clone https://github.com/eccenca/ckan_docker.git
cd ckan_docker
docker build -t registry.docker.eccenca.com/ckan:latest .
```

### eccenca/ckan_solr
```
cd ckan_docker/contrib/docker/solr
docker build -t registry.docker.eccenca.com/ckan_solr:latest .
```

### eccenca/ckan_postgresql
```
cd ckan_docker/contrib/docker/postgresql
docker build -t registry.docker.eccenca.com/ckan_postgresql:latest .
```

# run ckan
## solr
```
docker run -d --name ckan_solr_1 registry.docker.eccenca.com/ckan_solr:latest
```

## postgresql
```
docker run -d --name ckan_db_1 registry.docker.eccenca.com/ckan_postgresql:latest
```

## ckan
```
docker run -it --rm --link ckan_solr_1:solr --link ckan_db_1:db -p 80:80  --name registry.docker.eccenca.com/ckan:latest /bin/bash
```
within the container:
```
/sbin/my_init
```

or with
```
docker run -it --rm --link ckan_solr_1:solr --link ckan_db_1:db -p 80:80  --name eccenca_ckan registry.docker.eccenca.com/ckan:latest
```

### ckan configuration

The ckan.ini configuration file is created during container start. The following configuration parameter can be set on ``docker run`` using the ``-e <VARIABLE_NAME>=<VALUE> [-e ...]``:

* General settings
	* ``CKAN_SITE_URL`` (default: http://localhost)
	* ``CKAN_DEBUG`` (False)
	* ``CKAN_PLUGINS`` - add additional plugins (unset)
	* ``DB_FT_SEARCH_LANG`` (english)
* Internationalisation Settings
	* ``CKAN_LOCALE`` (en)
* Feeds Settings
	* ``CKAN_FEED_AUTHORITY``(unset)
	* ``CKAN_FEED_DATE``(unset)
	* ``CKAN_FEED_AUTHOR`` (unset)
	* ``CKAN_FEED_AUTHOR_LINK`` (unset)
* storage settings
	* ``CKAN_STORAGE_PATH`` (/var/lib/ckan)
* Email settings
	* ``EMAIL_TO`` (ckan-admin@localhost)
	* ``EMAIL_FROM`` (ckan_instance@localhost)
	* ``EMAIL_SMTP_SERVER`` (smtp.localhost)
	* ``EMAIL_SMTP_STARTTLS`` (True)
	* ``EMAIL_SMTP_USER`` (EXAMPLEUSER)
	* ``EMAIL_SMTP_PASS`` (EXAMPLEPASS)
	* ``EMAIL_SMTP_EMAIL_FROM`` (ckan_instance@localhost)
