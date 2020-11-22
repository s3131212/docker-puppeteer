#!/bin/bash
docker run -d -it -v ./test-code:/usr/src/app:rw \
	--security-opt="seccomp=./chrome.json" \
	--user=pptruser \
	--name puppeteer \
	puppeteer-image
