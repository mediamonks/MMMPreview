//
// MMMPreview.
// Copyright (C) 2021 MediaMonks. All rights reserved.
//

import SwiftUI

public protocol MMMPreviewContextParsable {
	func asContexts() -> [MMMPreviewContext]
}

extension Array: MMMPreviewContextParsable where Element == MMMPreviewContext {
	
	public func asContexts() -> [MMMPreviewContext] { self }
}

public struct MMMPreviewContext: Identifiable, MMMPreviewContextParsable {
	
	public enum Layout {
		case `default`
		case sizeThatFits
		case custom(width: CGFloat, height: CGFloat)
		case simulator(name: String)
	}
	
	public enum ColorMode {
		case light
		case dark
	}
	
	public static let `default` = MMMPreviewContext(layout: .default)
	public static let sizeThatFits = MMMPreviewContext(layout: .sizeThatFits)
	
	public let id: String
	
	public let displayName: String?
	public let layout: Layout
	public let scheme: ColorMode
	
	public init(
		displayName: String? = nil,
		layout: Layout = .default,
		scheme: ColorMode = .light
	) {
	
		self.id = UUID().uuidString
		
		self.displayName = displayName
		self.layout = layout
		self.scheme = scheme
	}
	
	public func asContexts() -> [MMMPreviewContext] { [self] }
}

@available(iOS 13, *)
extension MMMPreviewContext {
	
	internal var previewDevice: PreviewDevice? {
		switch layout {
		case .default, .sizeThatFits: return nil
		case .custom: return .init(stringLiteral: "iPhone 8")
		case .simulator(let name): return .init(stringLiteral: name)
		}
	}
	
	internal var previewLayout: PreviewLayout {
		switch layout {
		case .default, .simulator: return .device
		case .sizeThatFits: return .sizeThatFits
		case .custom(let width, let height): return .fixed(width: width, height: height)
		}
	}
	
	internal var colorScheme: ColorScheme {
		switch scheme {
		case .light: return .light
		case .dark: return .dark
		}
	}
}
