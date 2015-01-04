OGG:=libogg-1.3.2
VORBIS:=libvorbis-1.3.4

OGG_URL:="http://downloads.xiph.org/releases/ogg/$(OGG).tar.gz"
VORBIS_URL:="http://downloads.xiph.org/releases/vorbis/$(VORBIS).tar.gz"

EMCC_OPTS:=-s EXPORTED_FUNCTIONS="['_sp_ov_start', '_sp_ov_end', '_sp_ov_to_wave']"
EMCC_OPTS+=-s NO_BROWSER=1
EMCC_OPTS+=-O3 --memory-init-file 0 --closure 1
EMCC_OPTS+=--pre-js src/pre.js --post-js src/post.js

EMCC_LINKS:=-I libogg/install/include -Llibogg/install/lib -logg -I libvorbis/build/include -I libvorbis/include -Llibvorbis/build/lib -lvorbis
EMCC_SRCS:=src/vorbis.c libvorbis/lib/vorbisfile.c libvorbis/lib/.libs/libvorbis.a


all: oggvorbis.js

oggvorbis.js: libogg libvorbis src/pre.js src/post.js src/head.js src/vorbis.c
	emcc $(EMCC_OPTS) $(EMCC_LINKS) $(EMCC_SRCS) -o build.js && \
	cat src/head.js build.js > oggvorbis.js && \
	$(RM) -rf build.js
	
libogg: $(OGG).tar.gz
	tar xzvf $(OGG).tar.gz && \
	cd $(OGG) && \
	../libogg.sh && \
	cd ../ && mv $(OGG) libogg

libvorbis: $(VORBIS).tar.gz
	tar xzvf $(VORBIS).tar.gz && \
	cd $(VORBIS) && \
	../libvorbis.sh && \
	cd ../ && mv $(VORBIS) libvorbis

$(OGG).tar.gz:
	test -e "$@" || wget $(OGG_URL)

$(VORBIS).tar.gz:
	test -e "$@" || wget $(VORBIS_URL)

clean:
	$(RM) -rf libogg libvorbis

distclean: clean
	$(RM) $(VORBIS).tar.gz $(OGG).tar.gz

