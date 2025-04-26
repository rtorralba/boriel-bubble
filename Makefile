# build:
# 	zxbc main.bas -t -O3
# 	cat loader.tap main.tap > dist/game.tap

BIN_FOLDER=bin/
PROJECT_NAME=game

tiled-build:
	tiled --export-map json assets/maps.tmx output/maps.json
	python3 ${BIN_FOLDER}tiled-build.py

screens-build:
	python3 ${BIN_FOLDER}png2scr.py assets/screens/title.png
	java -jar ${BIN_FOLDER}zx0.jar -f assets/screens/title.png.scr output/title.png.scr.zx0
	rm assets/screens/title.png.scr
	python3 ${BIN_FOLDER}png2scr.py assets/screens/ending.png
	java -jar ${BIN_FOLDER}zx0.jar -f assets/screens/ending.png.scr output/ending.png.scr.zx0
	rm assets/screens/ending.png.scr
	#python3 ${BIN_FOLDER}png2scr.py assets/screens/loading.png

build:
	$(MAKE) tiled-build
	$(MAKE) screens-build
	zxbc -ta -O3 main.bas
	cat loader.tap main.tap assets/music.tap > dist/${PROJECT_NAME}.tap
	rm -f main.tap

run:
	fuse --machine=plus2a dist/${PROJECT_NAME}.tap