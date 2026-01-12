install:
	curl -fL https://github.com/coursier/coursier/releases/download/v2.1.8/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs
	# Coursier doesn't work with musl libc, so we need to use gcompat in alpine
	./cs setup --install-dir /usr/local/bin
	# Pre-download coursier index and cache dependencies
	export CI_DISABLE_PROGRESS_BAR=1
	export COURSIER_PROGRESS=0
	# Pre-warm coursier cache by fetching the index
	curl -s -o /dev/null https://github.com/coursier/jvm-index/raw/master/index.json || true
	echo 'object Test { def main(args: Array[String]) = println("Hello") }' > Test.scala
	scala run --quiet Test.scala
