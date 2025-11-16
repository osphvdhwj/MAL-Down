# MAL-Down Build Automation
# 2025 Flutter Build Scripts

.PHONY: help setup clean get generate analyze test build-debug build-release build-apk build-appbundle

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

help: ## Show this help message
	@echo '$(GREEN)MAL-Down Build Commands$(NC)'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-20s$(NC) %s\n", $$1, $$2}'

setup: ## Initial project setup
	@echo '$(GREEN)Setting up MAL-Down development environment...$(NC)'
	flutter doctor -v
	flutter pub get
	@echo '$(GREEN)Setup complete!$(NC)'

clean: ## Clean build artifacts
	@echo '$(YELLOW)Cleaning build artifacts...$(NC)'
	flutter clean
	rm -rf build/
	rm -rf .dart_tool/
	@echo '$(GREEN)Clean complete!$(NC)'

get: ## Get dependencies
	@echo '$(YELLOW)Getting dependencies...$(NC)'
	flutter pub get
	@echo '$(GREEN)Dependencies installed!$(NC)'

generate: ## Run code generation
	@echo '$(YELLOW)Running code generation...$(NC)'
	flutter pub run build_runner build --delete-conflicting-outputs
	@echo '$(GREEN)Code generation complete!$(NC)'

generate-watch: ## Watch for changes and regenerate
	@echo '$(YELLOW)Watching for changes...$(NC)'
	flutter pub run build_runner watch --delete-conflicting-outputs

analyze: ## Analyze code
	@echo '$(YELLOW)Analyzing code...$(NC)'
	dart format --set-exit-if-changed .
	flutter analyze
	@echo '$(GREEN)Analysis complete!$(NC)'

test: ## Run tests
	@echo '$(YELLOW)Running tests...$(NC)'
	flutter test --coverage
	@echo '$(GREEN)Tests complete!$(NC)'

test-coverage: test ## Generate coverage report
	@echo '$(YELLOW)Generating coverage report...$(NC)'
	genhtml coverage/lcov.info -o coverage/html
	@echo '$(GREEN)Coverage report generated in coverage/html$(NC)'

build-debug: ## Build debug APK
	@echo '$(YELLOW)Building debug APK...$(NC)'
	flutter build apk --debug
	@echo '$(GREEN)Debug APK built!$(NC)'

build-release: ## Build release APK (split per ABI)
	@echo '$(YELLOW)Building release APK...$(NC)'
	flutter build apk \
		--release \
		--split-per-abi \
		--target-platform android-arm64,android-arm \
		--obfuscate \
		--split-debug-info=build/app/outputs/symbols
	@echo '$(GREEN)Release APK built!$(NC)'
	@ls -lh build/app/outputs/flutter-apk/*.apk

build-apk-arm64: ## Build ARM64-only APK (Poco X5 Pro)
	@echo '$(YELLOW)Building ARM64 APK for Poco X5 Pro...$(NC)'
	flutter build apk \
		--release \
		--target-platform android-arm64 \
		--obfuscate \
		--split-debug-info=build/app/outputs/symbols
	@echo '$(GREEN)ARM64 APK built!$(NC)'
	@ls -lh build/app/outputs/flutter-apk/*.apk

build-appbundle: ## Build App Bundle for Play Store
	@echo '$(YELLOW)Building App Bundle...$(NC)'
	flutter build appbundle \
		--release \
		--target-platform android-arm64,android-arm \
		--obfuscate \
		--split-debug-info=build/app/outputs/symbols
	@echo '$(GREEN)App Bundle built!$(NC)'
	@ls -lh build/app/outputs/bundle/release/*.aab

run-dev: ## Run in development mode
	@echo '$(YELLOW)Running in development mode...$(NC)'
	flutter run --debug

run-release: ## Run in release mode
	@echo '$(YELLOW)Running in release mode...$(NC)'
	flutter run --release

run-profile: ## Run in profile mode
	@echo '$(YELLOW)Running in profile mode...$(NC)'
	flutter run --profile

install-release: build-apk-arm64 ## Build and install release APK
	@echo '$(YELLOW)Installing release APK...$(NC)'
	adb install -r build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
	@echo '$(GREEN)APK installed!$(NC)'

logcat: ## Show app logs
	@echo '$(YELLOW)Showing logs for com.maldown.app...$(NC)'
	adb logcat | grep -F "`adb shell pidof -s com.maldown.app`"

upgrade: ## Upgrade Flutter and dependencies
	@echo '$(YELLOW)Upgrading Flutter...$(NC)'
	flutter upgrade
	flutter pub upgrade --major-versions
	@echo '$(GREEN)Upgrade complete!$(NC)'

format: ## Format code
	@echo '$(YELLOW)Formatting code...$(NC)'
	dart format .
	@echo '$(GREEN)Formatting complete!$(NC)'

all: clean get generate analyze test build-release ## Clean, install, generate, analyze, test, and build
	@echo '$(GREEN)Full build pipeline complete!$(NC)'
