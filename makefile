build:
	@sh services/scripts/build.sh
test:
	@sh services/scripts/test.sh
clean:
	@sh services/scripts/clean.sh
build-deb:
	@sh services/scripts/debBuild.sh
lint-deb: build-deb
	@lintian merge_sort-v1.0.1.deb
docker-image:
	@docker build -t merge_sort:latest .
docker-run:
	@docker run -d --rm --mount type=bind,source=/tmp,target=/tmp merge_sort:latest