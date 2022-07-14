.PHONY: build publish test local-test kira-start kira-stop clean docker-start docker-clean docker-stop

build:
	./scripts/build.sh

publish:
	./scripts/publish.sh

test:
	./scripts/test.sh

local-test:
	./scripts/local-test.sh

kira-start:
	./scripts/kira-start.sh

kira-stop:
	./scripts/kira-stop.sh

clean:
	./scripts/clean.sh

docker-start:
	./scripts/docker-start.sh

docker-stop:
	./scripts/docker-stop.sh

docker-clean:
	./scripts/docker-clean.sh
