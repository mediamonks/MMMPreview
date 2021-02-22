//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

public protocol MMMControllerPreviewParsable {
	
	func asControllers() -> [UIViewController]
}

extension UIViewController: MMMControllerPreviewParsable {
	
	public func asControllers() -> [UIViewController] { [self] }
}

extension Array: MMMControllerPreviewParsable where Element: UIViewController {
	
	public func asControllers() -> [UIViewController] { self }
}
