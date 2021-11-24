regenerate-xcode:
	swift package generate-xcodeproj

test:
	swift test

# Please add git tag release manually and
# push it into the remote repo
publish:
	pod spec lint
	pod trunk push

.PHONY: regenerate-xcode test publish
