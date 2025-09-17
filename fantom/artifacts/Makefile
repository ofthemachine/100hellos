PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	curl -o fantom.zip -L https://github.com/fantom-lang/fantom/releases/download/v1.0.82/fantom-1.0.82.zip
	unzip fantom.zip -d fantom
	mv fantom/fantom-1.0.82 rel
	chmod +x rel/bin/*
	rm -rf fantom && rm -f fantom.zip
	echo -e "\n\njdkHome=$$JAVA_HOME/\ndevHome=/artifacts/fan/\n" >> rel/etc/build/config.props
	git clone https://github.com/fantom-lang/fantom fan
	cd fan && git checkout b8ea0c0569a3f731726f2133e619474b78952ae1
	echo -e "\n\njdkHome=$$JAVA_HOME/" >> fan/etc/build/config.props
	rel/bin/fan fan/src/buildall.fan superclean
	rel/bin/fan fan/src/buildboot.fan compile
	fan/bin/fan fan/src/buildpods.fan compile
