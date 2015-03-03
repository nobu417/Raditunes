//
//  raditunesAppDelegate.h
//  raditunes
//
//  Created by Nobuyuki Sato on 4/14/14.
//  Copyright (c) 2014 Nobuyuki Sato. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface raditunesAppDelegate : NSObject <NSApplicationDelegate>

// ======================================================================
// Outlets of root.
// ======================================================================
@property (assign) IBOutlet NSWindow *window;           // Main window.
@property (assign) IBOutlet NSWindow *prefWindow;       // Preference window.

// ======================================================================
// Outlets of main window.
// ======================================================================
@property (assign) IBOutlet WebView *webView;

// ======================================================================
// Outlets of preferene window.
// ======================================================================
@property (assign) IBOutlet NSView *prefPanel;          // Preference panel on preference window.
@property (assign) IBOutlet NSView *aboutPanel;         // About panel on preference window.

@property (assign) IBOutlet NSTextField *versionLabel;  // Label to show version information.
@property (assign) IBOutlet NSButton *Hokkaido;         // Checkbox of Hokkaido.
@property (assign) IBOutlet NSButton *Kanto;            // Checkbox of Kanto.
@property (assign) IBOutlet NSButton *Hokuriku;         // Checkbox of Hokuriku.
@property (assign) IBOutlet NSButton *Chubu;            // Checkbox of Chubu.
@property (assign) IBOutlet NSButton *Kinki;            // Checkbox of Kinki.
@property (assign) IBOutlet NSButton *Chugoku;          // Checkbox of Chugoku.
@property (assign) IBOutlet NSButton *Kyushu;           // Checkbox of Kyushu.
@property (assign) IBOutlet NSButton *Zenkoku;          // Checkbox of Zenkoku.

// ======================================================================
// Outlets of main menu.
// ======================================================================
@property (assign) IBOutlet NSMenuItem *menuHokkaido;   // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuKanto;      // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuHokuriku;   // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuChubu;      // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuKinki;      // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuChugoku;    // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuKyushu;     // Menu item of Hokkaido.
@property (assign) IBOutlet NSMenuItem *menuZenkoku;    // Menu item of Zenkoku.

@property (assign) IBOutlet NSMenuItem *menuPlaying;

// ======================================================================
// Events.
// ======================================================================
- (IBAction)showWindow:(id)sender;
- (IBAction)showPrefWindow:(id)sender;
- (IBAction)tuning:(id)sender;
- (IBAction)playAndPause:(id)sender;
- (IBAction)toggleIfMenuShown:(id)sender;

- (IBAction)togglePrefWindowPanels:(id)sender;
- (IBAction)openGitHub:(id)sender;
- (IBAction)openRadikoJp:(id)sender;

@end
