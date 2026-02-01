.PHONY: all print

# Find top-level directories (result: nvim/)
DIRS := $(wildcard */)

# Remove trailing slashes (result: nvim)
DIRS_CLEAN := $(patsubst %/,%,$(DIRS))

# Filter out directories not to be stowed (e.g., .git)
EXCLUDE := .git .github private documentation
PACKAGES := $(filter-out $(EXCLUDE), $(DIRS_CLEAN))

# Test which directories are detected
print:
	@echo $(PACKAGES)

# Default target stows all packages
all: $(PACKAGES)

# "make <package>" stows that package
.PHONY: $(PACKAGES)
$(PACKAGES):
	stow --verbose --target=$(HOME) --restow $@

# "make delete-<package>" deletes that package
.PHONY: delete-%
delete-%:
	stow --verbose --target=$(HOME) --delete $*
