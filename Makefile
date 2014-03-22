COFFEE=coffee

build:
	$(COFFEE) -cb -o . index.coffee

clean:
	rm -rf index.js
