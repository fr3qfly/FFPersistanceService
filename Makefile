.PHONY: test-cov

PROJECT = FFPersistanceService.xcodeproj
MYSCHEME = FFPersistanceService-Package

test-cov:
	swift package generate-xcodeproj
	slather setup ${PROJECT}
	xcodebuild -scheme ${MYSCHEME} -destination 'platform=iOS Simulator,name=iPhone Xs,OS=12.2' -enableCodeCoverage YES clean test # 
	slather
# 	slather coverage --scheme ${MYSCHEME} -x --source-directory ./ --output-directory ./TestResults --build-directory ./.build/xcode ./${PROJECT}
	

# swift package generate-xcodeproj
# slather setup FFPersistanceService.xcodeproj
# xcodebuild -scheme FFPersistanceService-Package -derivedDataPath ./.build/xcode -enableCodeCoverage YES test
# xcodebuild -scheme FFPersistanceService-Package -enableCodeCoverage YES test
# slather coverage --scheme FFPersistanceService-Package -x --output-directory ./TestResults --source-directory ./ --build-directory ./.build/xcode ./FFPersistanceService.xcodeproj

	