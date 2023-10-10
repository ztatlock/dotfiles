COOKIEJARS = jokes quotes art-of-living
DATS = $(patsubst %,%.dat,$(COOKIEJARS))

%.dat: %
	strfile $< $@

all: $(DATS)

.PHONY: clean
clean:
	rm -f $(DATS)
