//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public protocol MMMViewPreview: MMMControllerPreview {
	
	static func makeViews() -> MMMViewPreviewParsable
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	public static var context: MMMPreviewContextParsable { MMMPreviewContext.sizeThatFits }
}

@available(iOS 13, *)
public final class ViewPreviewController: UIViewController {
	
	private let _view: UIView
	
	public init(view: UIView) {
		self._view = view
		
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	internal required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func loadView() {
		self.view = _view
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
	}
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	public static func makeViewControllers() -> MMMControllerPreviewParsable {
		makeViews().asViews().map(ViewPreviewController.init)
	}
}
