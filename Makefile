.PHONY: test-cov

PROJECT = FFPersistanceService.xcodeproj
MYSCHEME = FFPersistanceService-Package

test-cov:
	@swift package generate-xcodeproj
# 	slather setup ${PROJECT}
# 	xcodebuild -scheme ${MYSCHEME} -derivedDataPath ./.build/xcode -enableCodeCoverage YES test # 
# 	slather coverage --scheme ${MYSCHEME} -x --source-directory ./ --output-directory ./TestResults --build-directory ./.build/xcode ./${PROJECT}
	slather setup FFPersistanceService.xcodeproj
	xcodebuild -scheme FFPersistanceService-Package -derivedDataPath ./.build/xcode -enableCodeCoverage YES test
	slather coverage --scheme FFPersistanceService-Package -x --source-directory ./ --output-directory ./TestResults --build-directory ./.build/xcode ./FFPersistanceService.xcodeproj
	@rm -r ./.build/xcode

	