regenerate-xcode:
	swift package generate-xcodeproj

test:
	swift test

.PHONY: regenerate-xcode test

