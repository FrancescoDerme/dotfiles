PACKAGES = nvim beets scripts

# Default target stows all packages
.PHONY: all
all: $(PACKAGES)

# "make <package>" stows that package
.PHONY: $(PACKAGES)
$(PACKAGES):
	stow --verbose --target=$(HOME) --restow $@

# "make delete-<package>" deletes that package
.PHONY: delete-%
delete-%:
	stow --verbose --target=$(HOME) --delete $*
