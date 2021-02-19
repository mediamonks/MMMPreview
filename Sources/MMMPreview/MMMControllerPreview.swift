//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@_exported import SwiftUI

@available(iOS 13, *)
public protocol MMMControllerPreview: PreviewProvider {
	
	associatedtype Controller: UIViewController
	
	static func makeViewController() -> Controller
	
	static var contexts: [MMMPreviewContext] { get }
}

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static var contexts: [MMMPreviewContext] { [.default] }
}

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static var previews: some View {
		
		ForEach(contexts) { context in
			ControllerRepresentable<Self>()
				.edgesIgnoringSafeArea(.all)
				.previewDevice(context.previewDevice)
				.previewLayout(context.previewLayout)
				.previewDisplayName(context.displayName)
				.preferredColorScheme(context.colorScheme)
		}
	}
}
