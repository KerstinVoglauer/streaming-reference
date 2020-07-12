VERSION := $(shell cat version.properties | grep version | cut -c 9-)
SCALA_VERSION := "2.12"

version:
	echo ${VERSION}

# NOTE: you need to have a running flink cluster up first
# i.e. on a mac with homebrew
# cd /usr/local/Cellar/apache-flink/1.10.1/libexec
# flink binary must be on the path, as well as its bin folder! Then:
# ./bin/start-cluster.sh

run-local-Socket:
	./gradlew :usecases:streamingWordcount:shadowJar
	flink run --class com.github.geoheil.streamingreference.streamingwc.StreamingWordCount \
		"usecases/streamingWordcount/build/libs/streamingWordcount_${SCALA_VERSION}-${VERSION}-all.jar"  \
		--host localhost --port 9000

run-local-TweetsMinimalistic01:
	./gradlew :usecases:tweets:shadowJar
	FLINK_ENV_JAVA_OPTS=-Dconfig.file="config/jobs/twitter-analysis.conf" \
	flink run --class com.github.geoheil.streamingreference.tweets.TweetsAnalysisMinimalistic01 \
		"usecases/tweets/build/libs/tweets_${SCALA_VERSION}-${VERSION}-all.jar"

run-local-Tweets:
	./gradlew :usecases:tweets:shadowJar
	FLINK_ENV_JAVA_OPTS=-Dconfig.file="config/jobs/twitter-analysis.conf" \
	flink run --class com.github.geoheil.streamingreference.tweets.TweetsAnalysis \
		"usecases/tweets/build/libs/tweets_${SCALA_VERSION}-${VERSION}-all.jar"

# to run on yarn read
# https://stackoverflow.com/questions/1322643/makefile-how-to-add-a-prefix-to-the-basename
# and the linked Flink mailinglist discussion

run-local-Anomaly:
	./gradlew :usecases:anomaly:shadowJar
	FLINK_ENV_JAVA_OPTS=-Dconfig.file="config/jobs/twitter-anomaly.conf" \
	flink run --class com.github.geoheil.streamingreference.anomaly.TweetAnomaly \
		"usecases/anomaly/build/libs/anomaly_${SCALA_VERSION}-${VERSION}-all.jar"