# MMMPreview

UIKit previews in your Xcode canvas. Leverages the SwiftUI preview window, but
displaying your `UIView`s / `UIViewController`s.

Having a preview of your `UIView` while developing is a real time saver, especially
when strictly using programmatic UI (like all the cool kids do).

(This is a part of `MMMTemple` suite of iOS libraries we use at
[MediaMonks](https://www.mediamonks.com/).)

## Installation

SPM:

```swift
.package(url: "https://github.com/mediamonks/MMMPreview", .upToNextMajor(from: "0.3.0"))
```

Podfile:

```ruby
source 'https://github.com/mediamonks/MMMSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'
...
pod 'MMMPreview'
```

## Preview

This is a regular old `UIViewController` being previewed using `MMMPreview`:

![Xcode Preview](https://raw.githubusercontent.com/mediamonks/MMMPreview/main/Example.png)

## Usage

The library itself has a minimum deployment target of iOS 11 to be compatible with the majority of projects,
however, it requires at least an iOS 13 simulator. For < iOS 13 projects, use the `@available(iOS 13, *)`
tag where referincing `MMMPreview`.

### Simple example

The easiest setup would be to just add the preview provider struct at the bottom of your UIView(controller) 
file.

**UIViewController**
```swift
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *) // Tag if your project is < iOS 13.
internal struct MyViewController_Previews: MMMControllerPreview, PreviewProvider {
	
	public static var previewViewControllers: MMMControllerPreviewParsable {
		
		// Setup your ViewController instance, e.g. with a ViewModel.
		// We can either return a single UIViewController instance or an array of 
		// controllers. 
		MyViewController(
			viewModel: MyMockViewModel(variation: .default)
		)
		
		// Since it's a resultBuilder; you can use the SwiftUI syntax, no array's needed.
		MyViewController(
			viewModel: MyMockViewModel(variation: .alternate)
		)
		
		// You can even do if/else statements.
		if foo {
			OtherViewController()
		}
	}
}

#endif
```

**UIView**
```swift
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *) // Tag if your project is < iOS 13.
internal struct MyView_Previews: MMMViewPreview, PreviewProvider {

	public static var previewViews: MMMViewPreviewParsable {

		// Setup your View instance, e.g. with a ViewModel.
		MyView(viewModel: MyMockViewModel())
		
		if condition {
			MyView(viewModel: OtherMockViewModel())
		}
	}
}

#endif
```

### More detailed example

By default the preview will use the current selected simulator; however, it's usually nice to check your views
for multiple screen sizes. You can provide the `MMMControllerPreview` / `MMMViewPreview` with different
`MMMPreviewContext`s, this can be done project-wide or per preview.

**Project**

```swift
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *)
extension MMMControllerPreview {
	
	// For project-wide extensions, we need the @MMMPreviewContextBuilder wrapper.
	@MMMPreviewContextBuilder public static var context: MMMPreviewContextParsable {
		// We can use the same SwiftUI syntax here.
		MMMPreviewContext(
			displayName: "iPhone SE", // Will be shown as preview title, not necesary.
			// The simulator name should exactly match.
			layout: .simulator(name: "iPhone SE (1st generation)")
		)
		
		MMMPreviewContext(
			displayName: "iPhone 11", // Will be shown as preview title.
			layout: .simulator(name: "iPhone 11"),
			scheme: .dark // Dark / light mode.
		)
	}
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	// For project-wide extensions, we need the @MMMPreviewContextBuilder wrapper.
	@MMMPreviewContextBuilder public static var context: MMMPreviewContextParsable {
		MMMPreviewContext(
			// A custom width / height for your preview.
			layout: .custom(width: 320, height: 300)
		)
		MMMPreviewContext(
			layout: .custom(width: 480, height: 120)
		)
	}
}

#endif
```

**Preview**

```swift
#if canImport(MMMPreview)

import MMMPreview

@available(iOS 13, *) // Tag if your project is < iOS 13.
internal struct MyView_Previews: MMMViewPreview, PreviewProvider {

	public static var previewViews: MMMViewPreviewParsable {
		
		// We can also provide multiple views, e.g. for when testing multiple states at once.
		
		MyView(viewModel: MyMockViewModel(state: .one))
		MyView(viewModel: MyMockViewModel(state: .two))
		MyView(viewModel: MyMockViewModel(state: .three))
		
		if state == .one {
			OtherView()
		} else {
			MyView()
		}
	}
	
	// This overrides the project-wide contexts.
	public static var context: MMMPreviewContextParsable {
		MMMPreviewContext(
			layout: .custom(width: 80, height: 140)
		)
	}
}

#endif
```
