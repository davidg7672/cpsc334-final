build:
	@sh services/scripts/build.sh
run:
	@./main
test:
	@sh test.sh
clean:
	@cd merge_sort
	@rm -f linkedlist_app linkedlist_tests
build-deb:
lint-deb:
docker-image:
docker-run: