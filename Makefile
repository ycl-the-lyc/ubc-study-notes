default: clean

clean:
	find ./ -type f -name '*.pdf' -exec rm -f {} +
