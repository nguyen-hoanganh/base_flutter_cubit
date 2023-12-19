.PHONY: build-runner
build-runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs 
build-android-dev: 
	flutter build apk --release --no-tree-shake-icons --flavor dev	
build-android-stg: 
	flutter build apk --release --no-tree-shake-icons --flavor staging
build-android-prd: 
	flutter build apk --release --no-tree-shake-icons --flavor production
build-ios-dev:
	flutter build ipa --no-tree-shake-icons --flavor dev --target lib/main.dart && open ./build/ios/archive/Runner.xcarchive
build-ios-stg:
	flutter build ipa --no-tree-shake-icons --flavor staging --target lib/main.dart && open ./build/ios/archive/Runner.xcarchive
build-ios-prd:
	flutter build ipa --no-tree-shake-icons --flavor production --target lib/main.dart && open ./build/ios/archive/Runner.xcarchive
generate: 
	flutter gen-l10n
	
.PHONY: watch-runner
watch-runner:
	flutter packages pub run build_runner watch --delete-conflicting-outputs
