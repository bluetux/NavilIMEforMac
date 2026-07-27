PROJECT       := NavilIME.xcodeproj
SCHEME        := NavilIME
CONFIGURATION := Release
APP_NAME      := NavilIME.app
BUILD_DIR     := build
INPUT_METHODS_DIR := $(HOME)/Library/Input Methods

.PHONY: all build install uninstall clean reload

all: build

build:
	xcodebuild -project $(PROJECT) -scheme $(SCHEME) -configuration $(CONFIGURATION) \
		-derivedDataPath $(BUILD_DIR) build
	rm -rf $(APP_NAME)
	cp -R "$(BUILD_DIR)/Build/Products/$(CONFIGURATION)/$(APP_NAME)" $(APP_NAME)

install: build
	rm -rf "$(INPUT_METHODS_DIR)/$(APP_NAME)"
	cp -R $(APP_NAME) "$(INPUT_METHODS_DIR)/"
	@$(MAKE) reload

reload:
	-pkill -x NavilIME
	@echo "Installed. Reselect NavilIME as the input source to load the new build."

uninstall:
	./uninstall.sh

clean:
	rm -rf $(BUILD_DIR) $(APP_NAME)
