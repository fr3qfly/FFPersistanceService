.PHONY: test-cov

MYSCHEME = FFPersistanceService-Package
DATE = ${date +"%Y%m%d"}
TARGET = ./TestResults

test-cov:
	@swift package generate-xcodeproj
	@xcodebuild -scheme ${MYSCHEME} -derivedDataPath .build/xcode -enableCodeCoverage YES test
	@cp -r ./.build/xcode/Logs/Test/*.xcresult  ${TARGET}
	@rm -r ./.build/xcode