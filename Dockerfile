FROM alpine

ENV LC_All=C

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev \
                         boost-system boost-dev boost-program_options boost-iostreams \
                         make gcc g++ musl-dev cmake zlib-dev imagemagick&& \
    cd /tmp && \
    git clone https://github.com/mapcrafter/mapcrafter.git --depth=1 && \
    cd mapcrafter && \
    cmake . && \
    make && \
    make install && \
    cd / && rm -rf /tmp/mapcrafter && \
    apk del git libpng-dev libjpeg-turbo-dev \
            boost-system boost-program_options boost-iostreams \
            make gcc g++ musl-dev cmake zlib-dev 

    VOLUME /worlds
    VOLUME /output
    add 1.12.1.jar ./
RUN mapcrafter_textures.py ./1.12.1.jar usr/local/share/mapcrafter/textures
    add render.conf ./
    add mapgen.sh ./
    ENTRYPOINT ["mapgen.sh"]
    
