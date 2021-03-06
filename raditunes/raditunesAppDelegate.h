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
@property (assign) IBOutlet WebView *webView;           // WebView that acts as player.

// ======================================================================
// Outlets of preferene window.
// ======================================================================
@property (assign) IBOutlet NSView *generalPanel;       // General panel on preference window.
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

@property (assign) IBOutlet NSTextField *radioGuideURL; // URL of radio guide.

@property (assign) IBOutlet NSButtonCell *useRadikoJp;  // Radio button to use radiko.jp as radio guide.
@property (assign) IBOutlet NSButtonCell *useCustomURL; // Radio button to use custom URL as radio guide.
@property (assign) IBOutlet NSMatrix *radioGuide;       // Radio group of radio guides.

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

@property (assign) IBOutlet NSMenuItem *menuPlaying;    // Menu item of station name currently playing. (Always disabled.)
@property (assign) IBOutlet NSMenuItem *menuOpenSite;   // Menu item to open station website currently playing.

// ======================================================================
// Events.
// ======================================================================
- (IBAction)showWindow:(id)sender;
- (IBAction)showPrefWindow:(id)sender;
- (IBAction)tuning:(id)sender;
- (IBAction)playAndPause:(id)sender;
- (IBAction)openStationsSite:(id)sender;
- (IBAction)toggleIfMenuShown:(id)sender;

- (IBAction)togglePrefWindowPanels:(id)sender;
- (IBAction)setRadioGuideMethodAndURL:(id)sender;

- (IBAction)openGitHub:(id)sender;
- (IBAction)openRadioGuide:(id)sender;

@end
