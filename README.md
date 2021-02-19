# MMMPreview

UIKit previews in your Xcode canvas. Leverages the SwiftUI preview window, but
displaying your UIViews / UIViewControllers.

Having a preview of your UIView while developing is a real time saver, especially
when strictly using programmatic UI (like all the cool kids do).

(This is a part of `MMMTemple` suite of iOS libraries we use at
[MediaMonks](https://www.mediamonks.com/).)

## Installation

SPM:

```
.package(url: "https://github.com/mediamonks/MMMPreview", .upToNextMajor(from: "0.1.0"))
```

Podfile:

```
source 'https://github.com/mediamonks/MMMSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'
...
pod 'MMMPreview'
```

## Usage

The library itself has a minimum deployment target of iOS 11 to be compatible with the majority of projects,
however, it requires at least an iOS 13 simulator. For < iOS 13 projects, use the `@available(iOS 13, *)`
tag where referincing `MMMPreview`.

### Simple example

The easiest setup would be to just add the preview provider struct at the bottom of your UIView(controller) 
file.

**UIViewController**
```
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *) // Tag if your project is < iOS 13.
internal struct MyViewController_Previews: MMMControllerPreview, PreviewProvider {
	
	public static func makeViewController() -> UIViewController {
		
		// Setup your ViewController instance, e.g. with a ViewModel.
		let model = MyMockViewModel()
		let controller = MyViewController(viewModel: model)
		
		return controller
	}
}

#endif
```

**UIView**
```
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *) // Tag if your project is < iOS 13.
internal struct MyView_Previews: MMMViewPreview, PreviewProvider {

	public static func makeView() -> UIView {

		// Setup your View instance, e.g. with a ViewModel.
		let model = MyMockViewModel()
		let view = MyView(viewModel: model)
		
		return view
	}
}

#endif
```

### More detailed example

By default the preview will use the current selected simulator; however, it's usually nice to check your views
for multiple screen sizes. You can provide the `MMMControllerPreview` / `MMMViewPreview` with different
`MMMPreviewContext`s, this can be done project-wide or per preview.

**Project**

```
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static var contexts: [MMMPreviewContext] {
		[
			MMMPreviewContext(
				displayName: "iPhone SE", // Will be shown as preview title, not necesary.
				// The simulator name should exactly match.
				layout: .simulator(name: "iPhone SE (1st generation)")
			),
			MMMPreviewContext(
				displayName: "iPhone 11", // Will be shown as preview title.
				layout: .simulator(name: "iPhone 11"),
				scheme: .dark // Dark / light mode.
			)
		]
	}
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	public static var contexts: [MMMPreviewContext] {
		[
			MMMPreviewContext(
				// A custom width / height for your preview.
				layout: .custom(width: 320, height: 300)
			),
			MMMPreviewContext(
				layout: .custom(width: 320, height: 300),
				scheme: .dark
			)
		]
	}
}

#endif
```

**Preview**

```
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *) // Tag if your project is < iOS 13.
internal struct MyView_Previews: MMMViewPreview, PreviewProvider {

	public static func makeView() -> UIView {

		// Setup your View instance, e.g. with a ViewModel.
		let model = MyMockViewModel()
		let view = MyView(viewModel: model)
		
		return view
	}
	
	// This overrides the project-wide contexts.
	public static var contexts: [MMMPreviewContext] {
		[
			MMMPreviewContext(
				layout: .custom(width: 80, height: 140)
			)
		]
	}
}

#endif
```
