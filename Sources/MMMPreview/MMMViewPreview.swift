//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public protocol MMMViewPreview: MMMControllerPreview {
	
	static func makeViews() -> MMMViewPreviewParsable
	
	@MMMViewPreviewBuilder static var previewViews: MMMViewPreviewParsable { get }
	
	static var contexts: [MMMPreviewContext] { get }
	
	@MMMPreviewContextBuilder static var context: MMMPreviewContextParsable { get }
}

@available(iOS 13, *)
extension MMMViewPreview {
	
	public static func makeViews() -> MMMViewPreviewParsable {
		[]
	}
	
	public static var previewViews: MMMViewPreviewParsable {
		makeViews().asViews()
	}
	
	public static var contexts: [MMMPreviewContext] { context.asContexts() }
	
	@MMMPreviewContextBuilder public static var context: MMMPreviewContextParsable { MMMPreviewContext.sizeThatFits }
}

@_functionBuilder
public struct MMMViewPreviewBuilder {
	
	public static func buildBlock() -> [UIView] { [] }
	
	public static func buildBlock(_ values: MMMViewPreviewParsable...) -> [UIView] {
        values.flatMap { $0.asViews() }
    }
    
    public static func buildIf(_ value: MMMViewPreviewParsable?) -> MMMViewPreviewParsable {
        value ?? []
    }
    
    public static func buildEither(first: MMMViewPreviewParsable) -> MMMViewPreviewParsable {
        first
    }

    public static func buildEither(second: MMMViewPreviewParsable) -> MMMViewPreviewParsable {
        second
    }
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
		previewViews.asViews().map(ViewPreviewController.init)
	}
}
