//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
internal struct ControllerRepresentable<Preview: MMMControllerPreview>: UIViewControllerRepresentable {
	
	public func makeUIViewController(context: Context) -> Preview.Controller {
		return Preview.makeViewController()
	}

	public func updateUIViewController(
		_ uiViewController: Preview.Controller,
		context: Context
	) {
		// Nothing for now.
	}
}
