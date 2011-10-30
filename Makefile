test:

	@./node_modules/.bin/expresso \
	$(shell find testing/unit -name "*.test.coffee" -type f)

.PHONY: test