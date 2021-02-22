//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

public protocol MMMViewPreviewParsable {
	
	func asViews() -> [UIView]
}

extension UIView: MMMViewPreviewParsable {
	
	public func asViews() -> [UIView] { [self] }
}

extension Array: MMMViewPreviewParsable where Element: UIView {
	
	public func asViews() -> [UIView] { self }
}
