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

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *prefWindow;
@property (assign) IBOutlet WebView *webView;

@property (assign) IBOutlet NSView *prefPanel;
@property (assign) IBOutlet NSView *aboutPanel;
@property (assign) IBOutlet NSTextField *versionLabel;

@property (assign) IBOutlet NSButton *Hokkaido;
@property (assign) IBOutlet NSButton *Kanto;
@property (assign) IBOutlet NSButton *Hokuriku;
@property (assign) IBOutlet NSButton *Chubu;
@property (assign) IBOutlet NSButton *Kinki;
@property (assign) IBOutlet NSButton *Chugoku;
@property (assign) IBOutlet NSButton *Kyushu;
@property (assign) IBOutlet NSButton *Zenkoku;

@property (assign) IBOutlet NSMenuItem *menuHokkaido;
@property (assign) IBOutlet NSMenuItem *menuKanto;
@property (assign) IBOutlet NSMenuItem *menuHokuriku;
@property (assign) IBOutlet NSMenuItem *menuChubu;
@property (assign) IBOutlet NSMenuItem *menuKinki;
@property (assign) IBOutlet NSMenuItem *menuChugoku;
@property (assign) IBOutlet NSMenuItem *menuKyushu;
@property (assign) IBOutlet NSMenuItem *menuZenkoku;

- (IBAction)showWindow:(id)sender;
- (IBAction)showPrefWindow:(id)sender;
- (IBAction)tuning:(id)sender;
- (IBAction)playAndPause:(id)sender;
- (IBAction)toggleIfMenuShown:(id)sender;

- (IBAction)togglePrefWindowPanels:(id)sender;
- (IBAction)openGitHub:(id)sender;

@end
