BUILDDIR         ?= build
PLUGINS_OUT_DIR  ?= $(BUILDDIR)/plugins
CC               ?= cc
LD               ?= ld
CFLAGS           ?=
LDFLAGS          ?=

DATA_SRC         := data.js
MOVE_SRC         := move.js
ACTIVATE_SRC     := activate.js
RESTORE_SRC      := restore.js
ROOT_SRC         := root.c
DATA_OBJ         := $(BUILDDIR)/data.o
MOVE_OBJ         := $(BUILDDIR)/move.o
ACTIVATE_OBJ     := $(BUILDDIR)/activate.o
RESTORE_OBJ      := $(BUILDDIR)/restore.o
ROOT_OBJ         := $(BUILDDIR)/root.o
TARGET           := $(PLUGINS_OUT_DIR)/libkwinsupport.so

.PHONY: all clean
all: $(TARGET)

# ensure build dirs exist
$(BUILDDIR) $(PLUGINS_OUT_DIR):
	@mkdir -p $@

# embed data.js as an object file
$(DATA_OBJ): $(DATA_SRC) | $(BUILDDIR)
	$(LD) -r -b binary $< -o $@

$(MOVE_OBJ): $(MOVE_SRC) | $(BUILDDIR)
	$(LD) -r -b binary $< -o $@

$(RESTORE_OBJ): $(RESTORE_SRC) | $(BUILDDIR)
	$(LD) -r -b binary $< -o $@

$(ACTIVATE_OBJ): $(ACTIVATE_SRC) | $(BUILDDIR)
	$(LD) -r -b binary $< -o $@

# compile root.c
$(ROOT_OBJ): $(ROOT_SRC) | $(BUILDDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -fPIC

# link shared object
$(TARGET): $(DATA_OBJ) $(MOVE_OBJ) $(RESTORE_OBJ) $(ACTIVATE_OBJ) $(ROOT_OBJ) | $(PLUGINS_OUT_DIR)
	$(CC) $(LDFLAGS) -shared -lwayland-shimeji-plugins -lsystemd -o $@ $^

# clean up
clean:
	rm -rf $(BUILDDIR) $(TARGET)
