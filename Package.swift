// swift-tools-version:5.1
import PackageDescription

let package = Package(
	name: "MMMPreview",
	platforms: [
		.iOS(.v11)
	],
	products: [
		.library(
			name: "MMMPreview",
			targets: ["MMMPreview"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "MMMPreview",
			dependencies: [],
			path: "Sources"
		)
	]
)
