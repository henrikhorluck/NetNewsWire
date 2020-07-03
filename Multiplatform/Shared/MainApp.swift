//
//  MainApp.swift
//  Shared
//
//  Created by Maurice Parker on 6/27/20.
//  Copyright © 2020 Ranchero Software. All rights reserved.
//

import SwiftUI

@main
struct MainApp: App {
	
	#if os(macOS)
	@NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate
	#endif
	#if os(iOS)
	@UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
	#endif
	
	@StateObject private var sceneModel = SceneModel()
	@StateObject private var defaults = AppDefaults.shared
	@State private var showSheet = false
	
	@SceneBuilder var body: some Scene {
		#if os(macOS)
		WindowGroup {
			SceneNavigationView()
				.frame(minWidth: 600, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 700, maxHeight: .infinity)
				.environmentObject(sceneModel)
				.environmentObject(defaults)
				.sheet(isPresented: $showSheet, onDismiss: { showSheet = false }) {
					AddWebFeedView()
				}
				.toolbar {
					
					ToolbarItem {
						Button(action: { showSheet = true }, label: {
							Image(systemName: "plus").foregroundColor(.secondary)
						}).help("Add Feed")
					}
				
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "folder.fill.badge.plus").foregroundColor(.pink)
						}).help("New Folder")
					}
					
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "arrow.clockwise").foregroundColor(.secondary)
						}).help("Refresh").padding(.trailing, 40)
					}
					
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "circle.dashed").foregroundColor(.orange)
						}).help("Mark All as Read")
					}
					
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "arrow.triangle.turn.up.right.circle.fill").foregroundColor(.purple)
						}).help("Go to Next Unread")
					}
					
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "star.fill").foregroundColor(.yellow)
						}).help("Mark as Starred")
					}
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
						}).help("Mark as Unread")
					}
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "safari").foregroundColor(.blue)
						}).help("Open in Browser")
					}
					ToolbarItem {
						Button(action: {}, label: {
							Image(systemName: "square.and.arrow.up")
						}).help("Share")
					}
					
					ToolbarItem {
						MacSearchField()
							.frame(width: 300)
					}
				}
		}
		.commands {
			CommandGroup(after: .newItem, addition: {
				Button("New Feed", action: {})
					.keyboardShortcut("N")
				Button("New Folder", action: {})
					.keyboardShortcut("N", modifiers: [.shift, .command])
				Button("Refresh", action: {})
					.keyboardShortcut("R")
			})
			CommandMenu("Subscriptions", content: {
				Button("Import Subscriptions", action: {})
					.keyboardShortcut("I", modifiers: [.shift, .command])
				Button("Import NNW 3 Subscriptions", action: {})
					.keyboardShortcut("O", modifiers: [.shift, .command])
				Button("Export Subscriptions", action: {})
					.keyboardShortcut("E", modifiers: [.shift, .command])
			})
			CommandMenu("Go", content: {
				Button("Next Unread", action: {})
					.keyboardShortcut("/", modifiers: [.command])
				Button("Today", action: {})
					.keyboardShortcut("1", modifiers: [.command])
				Button("All Unread", action: {})
					.keyboardShortcut("2", modifiers: [.command])
				Button("Starred", action: {})
					.keyboardShortcut("3", modifiers: [.command])
			})
			CommandMenu("Article", content: {
				Button("Mark as Read", action: {})
					.keyboardShortcut("U", modifiers: [.shift, .command])
				Button("Mark All as Read", action: {})
					.keyboardShortcut("K", modifiers: [.command])
				Button("Mark Older as Read", action: {})
					.keyboardShortcut("K", modifiers: [.shift, .command])
				Button("Mark as Starred", action: {})
					.keyboardShortcut("L", modifiers: [.shift, .command])
				Button("Open in Browser", action: {})
					.keyboardShortcut(.rightArrow, modifiers: [.command])
			})
		}
		.windowToolbarStyle(UnifiedWindowToolbarStyle())
		
		// Mac Preferences
		Settings {
			MacPreferencesView()
			.padding()
			.frame(width: 500)
			.navigationTitle("Preferences")
			.environmentObject(defaults)
		}
		.windowToolbarStyle(UnifiedWindowToolbarStyle())
		
		#endif
		
		#if os(iOS)
		WindowGroup {
			SceneNavigationView()
				.environmentObject(sceneModel)
				.environmentObject(defaults)
				.modifier(PreferredColorSchemeModifier(preferredColorScheme: defaults.userInterfaceColorPalette))
		}
		.commands {
			CommandGroup(after: .newItem, addition: {
				Button("New Feed", action: {})
					.keyboardShortcut("N")
				Button("New Folder", action: {})
					.keyboardShortcut("N", modifiers: [.shift, .command])
				Button("Refresh", action: {})
					.keyboardShortcut("R")
			})
			CommandGroup(before: .sidebar, addition: {
				Button("Show Sidebar", action: {})
					.keyboardShortcut("S", modifiers: [.control, .command])
			})
			CommandMenu("Subscriptions", content: {
				Button("Import Subscriptions", action: {})
					.keyboardShortcut("I", modifiers: [.shift, .command])
				Button("Import NNW 3 Subscriptions", action: {})
					.keyboardShortcut("O", modifiers: [.shift, .command])
				Button("Export Subscriptions", action: {})
					.keyboardShortcut("E", modifiers: [.shift, .command])
			})
			CommandMenu("Go", content: {
				Button("Next Unread", action: {})
					.keyboardShortcut("/", modifiers: [.command])
				Button("Today", action: {})
					.keyboardShortcut("1", modifiers: [.command])
				Button("All Unread", action: {})
					.keyboardShortcut("2", modifiers: [.command])
				Button("Starred", action: {})
					.keyboardShortcut("3", modifiers: [.command])
			})
			CommandMenu("Article", content: {
				Button("Mark as Read", action: {})
					.keyboardShortcut("U", modifiers: [.shift, .command])
				Button("Mark All as Read", action: {})
					.keyboardShortcut("K", modifiers: [.command])
				Button("Mark Older as Read", action: {})
					.keyboardShortcut("K", modifiers: [.shift, .command])
				Button("Mark as Starred", action: {})
					.keyboardShortcut("L", modifiers: [.shift, .command])
				Button("Open in Browser", action: {})
					.keyboardShortcut(.rightArrow, modifiers: [.command])
			})
		}
		#endif
	}
}

struct PreferredColorSchemeModifier: ViewModifier {

	var preferredColorScheme: UserInterfaceColorPalette

	@ViewBuilder
	func body(content: Content) -> some View {
		switch preferredColorScheme {
		case .automatic:
			content
		case .dark:
			content.preferredColorScheme(.dark)
		case .light:
			content.preferredColorScheme(.light)
		}
	}
}
