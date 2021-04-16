//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@_exported import SwiftUI

@available(iOS 13, *)
public protocol MMMControllerPreview: PreviewProvider {
	
	static func makeViewControllers() -> MMMControllerPreviewParsable
	
	@MMMControllerPreviewBuilder static var previewViewControllers: MMMControllerPreviewParsable { get }
	
	static var contexts: [MMMPreviewContext] { get }
	
	@MMMPreviewContextBuilder static var context: MMMPreviewContextParsable { get }
}

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static func makeViewControllers() -> MMMControllerPreviewParsable {
		[]
	}
	
	public static var previewViewControllers: MMMControllerPreviewParsable {
		makeViewControllers().asControllers()
	}
	
	public static var contexts: [MMMPreviewContext] { context.asContexts() }
	
	@MMMPreviewContextBuilder public static var context: MMMPreviewContextParsable { MMMPreviewContext.default }
}

@_functionBuilder
public struct MMMControllerPreviewBuilder {
	
	public static func buildBlock() -> [UIViewController] { [] }
	
	public static func buildBlock(_ values: MMMControllerPreviewParsable...) -> [UIViewController] {
        values.flatMap { $0.asControllers() }
    }
    
    public static func buildIf(_ value: MMMControllerPreviewParsable?) -> MMMControllerPreviewParsable {
        value ?? []
    }
    
    public static func buildEither(first: MMMControllerPreviewParsable) -> MMMControllerPreviewParsable {
        first
    }

    public static func buildEither(second: MMMControllerPreviewParsable) -> MMMControllerPreviewParsable {
        second
    }
}

extension UIViewController: Identifiable {}

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static var previews: some View {
		
		ForEach(previewViewControllers.asControllers()) { controller in
			ForEach(contexts) { context in
				ControllerRepresentable(controller: controller)
					.edgesIgnoringSafeArea(.all)
					.previewDevice(context.previewDevice)
					.previewLayout(context.previewLayout)
					.previewDisplayName(context.displayName)
					.preferredColorScheme(context.colorScheme)
			}
		}
	}
}
