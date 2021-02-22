//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
internal struct ControllerRepresentable: UIViewControllerRepresentable {
	
	private let controller: UIViewController
	
	public init(controller: UIViewController) {
		self.controller = controller
	}
	
	public func makeUIViewController(context: Context) -> UIViewController {
		return controller
	}

	public func updateUIViewController(
		_ uiViewController: UIViewController,
		context: Context
	) {
		// Nothing for now.
	}
}
