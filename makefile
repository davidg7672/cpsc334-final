build:
	@sh services/scripts/build.sh
test:
	@sh services/scripts/test.sh
clean:
	@sh services/scripts/clean.sh
build-deb:
	@sh services/scripts/debBuild.sh
lint-deb: build-deb
	@lintian merge-sort-v1.0.1.deb
docker-image:
	@docker build -t merge-sort:latest .
docker-run:
	@docker run -d --rm --mount type=bind,source=/tmp,target=/tmp merge-sort:latest