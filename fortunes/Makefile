COOKIEJARS = jokes quotes art-of-living
DATS = $(patsubst %,%.dat,$(COOKIEJARS))

%.dat: %
	strfile -s $< $@

all: $(DATS)

.PHONY: clean
clean:
	rm -f $(DATS)
