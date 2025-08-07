UNAME_S := $(shell uname -s)

PREFIX := dist/

CXX := clang++
CXXFLAGS := -std=c++20 -fPIC -O2

ifeq ($(UNAME_S), Darwin)
    EXT := dylib
    LDFLAGS := -dynamiclib -undefined suppress -flat_namespace
else
    EXT := so
    LDFLAGS := -shared
endif

TARGET := src/lix-math.$(EXT)

all: $(TARGET)
.PHONY: all

src/%.$(EXT): src/%.cc
	$(CXX) $(CXXFLAGS) -o $@ $< $(LDFLAGS)

install:
	@mkdir -p $(PREFIX)
	@cp src/*.$(EXT) $(PREFIX)

