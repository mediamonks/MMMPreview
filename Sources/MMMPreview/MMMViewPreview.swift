//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public protocol MMMViewPreview: MMMControllerPreview {
	
	static func makeView() -> UIView
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	public static var contexts: [MMMPreviewContext] { [MMMPreviewContext(layout: .sizeThatFits)] }
}

@available(iOS 13, *)
public final class ViewPreviewController<Preview: MMMViewPreview>: UIViewController {
	
	public init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	internal required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func loadView() {
		self.view = Preview.makeView()
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
	}
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	public static func makeViewController() -> ViewPreviewController<Self> {
		ViewPreviewController()
	}
}
