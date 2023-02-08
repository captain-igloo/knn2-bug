FROM php:8.1-cli

WORKDIR /build

RUN apt update \
    && apt install -y \
    fossil \
    libexpat1-dev \
    libgeos-dev \
    libminizip-dev \
    libproj-dev \
    libreadosm-dev \
    librttopo-dev \
    libsqlite3-dev \
    libxml2-dev \
    zlib1g-dev

RUN cd /build \
    && fossil clone https://www.gaia-gis.it/fossil/freexl freexl.fossil --user anonymous \
    && mkdir freexl \
    && cd freexl \
    && fossil open ../freexl.fossil \
    && ./configure --prefix=/usr \
    && make \
    && make install

RUN cd /build \
    && fossil clone https://www.gaia-gis.it/fossil/libspatialite libspatialite.fossil --user anonymous \
    && mkdir libspatialite \
    && cd libspatialite \
    && fossil open ../libspatialite.fossil \
    && ./configure --prefix=/usr --disable-geos3100 \
    && make \
    && make install

RUN cd /build \
    && fossil clone https://www.gaia-gis.it/fossil/spatialite-tools spatialite-tools.fossil --user anonymous \
    && mkdir spatialite-tools \
    && cd spatialite-tools \
    && fossil open ../spatialite-tools.fossil \
    && ./configure --prefix=/usr \
    && make \
    && make install

COPY ./test.sql /build/

RUN cd /build \
    && spatialite ./test.db < ./test.sql

ENTRYPOINT ["spatialite", "/build/test.db"]
