PREFIX := $(HOME)
MAKE_PATH := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
DOCKERHUB_USER ?= ctxsh
VERSION := v1.3

.PHONY: all
all: java

###################################################################################################
# Java
###################################################################################################
.PHONY: java
java: jdk8 jre8 jdk11 jre11 jdk14 jre14

###################################################################################################
# Java build and release targets
###################################################################################################
.PHONY: jdk8
jdk8:
	@docker build \
		--build-arg "URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u282-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u282b08.tar.gz" \
		--tag $(DOCKERHUB_USER)/java:jdk8 \
		--file Dockerfile \
		.

.PHONY: jre8
jre8:
	@docker build \
		--build-arg "URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u282-b08/OpenJDK8U-jre_x64_linux_hotspot_8u282b08.tar.gz" \
		--tag $(DOCKERHUB_USER)/java:jre8 \
		--file Dockerfile \
		.

.PHONY: jdk11
jdk11:
	@docker build \
		--build-arg "URL=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.10%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.10_9.tar.gz" \
		--tag $(DOCKERHUB_USER)/java:jdk11 \
		--file Dockerfile \
		.

.PHONY: jre11
jre11:
	@docker build \
		--build-arg "URL=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.10%2B9/OpenJDK11U-jre_x64_linux_hotspot_11.0.10_9.tar.gz" \
		--tag $(DOCKERHUB_USER)/java:jre11 \
		--file Dockerfile \
		.

.PHONY: jdk14
jdk14:
	@docker build \
		--build-arg "URL=https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.2%2B12/OpenJDK14U-jdk_x64_linux_hotspot_14.0.2_12.tar.gz" \
		--tag $(DOCKERHUB_USER)/java:jdk14 \
		--file Dockerfile \
		.

.PHONY: jre14
jre14:
	@docker build \
		--build-arg "URL=https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.2%2B12/OpenJDK14U-jre_x64_linux_hotspot_14.0.2_12.tar.gz" \
		--tag $(DOCKERHUB_USER)/java:jre14 \
		--file Dockerfile \
		.

###################################################################################################
# Utility targets
###################################################################################################
clean:
	@docker rm $(shell docker ps -qa) || true
	@docker rmi $(shell docker images -q $(DOCKERHUB_USER)/java) --force || true
