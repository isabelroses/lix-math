PREFIX := "dist/"

CXX := clang++
CXXFLAGS := -std=c++20 -fPIC -O2
LDFLAGS := -shared

all: src/lix-math.so
.PHONY: all

src/%.so: src/%.cc
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $< $(LDFLAGS)

install:
	@mkdir -p $(PREFIX)
	@cp src/*.so $(PREFIX)
