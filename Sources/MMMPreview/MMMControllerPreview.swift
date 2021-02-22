//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@_exported import SwiftUI

@available(iOS 13, *)
public protocol MMMControllerPreview: PreviewProvider {
	
	static func makeViewControllers() -> MMMControllerPreviewParsable
	
	static var context: MMMPreviewContextParsable { get }
}

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static var context: MMMPreviewContextParsable { MMMPreviewContext.default }
}

extension UIViewController: Identifiable {}

@available(iOS 13, *)
extension MMMControllerPreview {
	
	public static var previews: some View {
		
		ForEach(makeViewControllers().asControllers()) { controller in
			ForEach(context.asContexts()) { context in
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
