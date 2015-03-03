//
//  raditunesAppDelegate.m
//  raditunes
//
//  Created by Nobuyuki Sato on 4/14/14.
//  Copyright (c) 2014 Nobuyuki Sato. All rights reserved.
//

#import "raditunesAppDelegate.h"

@interface raditunesAppDelegate ()
@property (weak) IBOutlet NSMenu *statusMenu;
@property (assign, nonatomic) BOOL darkModeOn;
@end

@implementation raditunesAppDelegate {
    NSStatusItem *_statusItem;
    NSMenuItem *currentItem;
    NSDictionary *dic;
    NSUserDefaults *userDefaults;
    NSInteger status;
    NSString *radioGuideURLString;
    NSString *radioGuideMethod;
}

// ======================================================================
// Main.
// ======================================================================
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Loading UserDefaults.
    userDefaults = [NSUserDefaults standardUserDefaults];
    // Setting areas to show based on UserDefaults.
    int array[2] = {1, 0};
    array[0] = 1;
    array[1] = 0;
    [_menuHokkaido setHidden:array[[userDefaults integerForKey: @"Hokkaido"]]];
    [_menuKanto setHidden:array[[userDefaults integerForKey: @"Kanto"]]];
    [_menuHokuriku setHidden:array[[userDefaults integerForKey: @"Hokuriku"]]];
    [_menuChubu setHidden:array[[userDefaults integerForKey: @"Chubu"]]];
    [_menuKinki setHidden:array[[userDefaults integerForKey: @"Kinki"]]];
    [_menuChugoku setHidden:array[[userDefaults integerForKey: @"Chugoku"]]];
    [_menuKyushu setHidden:array[[userDefaults integerForKey: @"Kyushu"]]];
    [_menuZenkoku setHidden:array[[userDefaults integerForKey: @"Zenkoku"]]];

    // Restoring status of checkboxs based on UserDefaults.
    [_Hokkaido setState: [userDefaults integerForKey: @"Hokkaido"]];
    [_Kanto setState: [userDefaults integerForKey: @"Kanto"]];
    [_Hokuriku setState: [userDefaults integerForKey: @"Hokuriku"]];
    [_Chubu setState: [userDefaults integerForKey: @"Chubu"]];
    [_Kinki setState: [userDefaults integerForKey: @"Kinki"]];
    [_Chugoku setState: [userDefaults integerForKey: @"Chugoku"]];
    [_Kyushu setState: [userDefaults integerForKey: @"Kyushu"]];
    [_Zenkoku setState: [userDefaults integerForKey: @"Zenkoku"]];
    
    radioGuideMethod = [userDefaults valueForKey: @"Guide"];
    radioGuideURLString = [userDefaults valueForKey: @"CustomURL"];
    
    NSLog(radioGuideMethod);
    
    if ([radioGuideMethod isEqualToString: @"custom"]) {
        [_useRadikoJp setState: false];
        [_useCustomURL setState: true];
    } else {
        [_useRadikoJp setState: true];
        [_useCustomURL setState: false];
    }
    
    if (radioGuideURLString != nil) {
      [_radioGuideURL setStringValue: radioGuideURLString];
    }
    
    // Loading the stations from dictonary.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"channels" ofType:@"plist"];
    dic = [NSDictionary dictionaryWithContentsOfFile: path];
    status = 0;
    [_webView setMainFrameURL:@"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id="];

    // Checking if it's darkmode and setting up icon on Menubar.
    [self refreshDarkMode];
    [self setupStatusItem];
}

// ======================================================================
// Main :: Initializing event for menubar.
// ======================================================================
- (void)setupStatusItem
{
    NSStatusBar *systemStatusBar = [NSStatusBar systemStatusBar];
    _statusItem = [systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    NSImage *image= [NSImage imageNamed:@"icon"];
    [image setTemplate:YES];
    [_statusItem setImage:image];
    [_statusItem setMenu:self.statusMenu];
}

// ======================================================================
// Main window :: Event to check if it's darkmode.
// ======================================================================
- (void)refreshDarkMode {
    NSString *value = (__bridge NSString *)(CFPreferencesCopyValue((CFStringRef)@"AppleInterfaceStyle", kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost));
    if ([value isEqualToString:@"Dark"]) {
        self.darkModeOn = YES;
    }
    else {
        self.darkModeOn = NO;
    }
}

// ======================================================================
// Main window :: Showing event.
// ======================================================================
-(IBAction)showWindow:(id)sender
{
    [[NSApplication sharedApplication] activateIgnoringOtherApps : YES];
    [_window makeKeyAndOrderFront:_window];
    [_window orderWindow:NSWindowAbove relativeTo:0];
}

// ======================================================================
// Main window :: Closing event.
// ======================================================================
- (BOOL)windowShouldClose:(id)sender
{
    // Do not close window.
    // Just to hide and set it working on background.
    [_window orderOut:sender];
    return NO;
}

// ======================================================================
// Preference window :: Showing event.
// ======================================================================
-(IBAction)showPrefWindow:(id)sender
{
    [_generalPanel setHidden: false];
    [_aboutPanel setHidden: true];
    [[NSApplication sharedApplication] activateIgnoringOtherApps : YES];
    [_prefWindow makeKeyAndOrderFront:_prefWindow];
    [_prefWindow orderWindow:NSWindowAbove relativeTo:0];
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [_versionLabel setStringValue: [NSString stringWithFormat:@"Version %@", version]];
}

// ======================================================================
// Mainmenu :: Play/Pause
// ======================================================================
- (IBAction)playAndPause:(id)sender
{
    if ((currentItem != nil) && (status == 0)) {
        // To play.
        int tag_value = (int)[currentItem tag];
        status = 1;
        NSString *stationKey = [[NSNumber numberWithUnsignedInt: tag_value] stringValue];
        NSString *stationId = [dic objectForKey:stationKey];
        NSString *uriBase = @"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id=";
        NSString *uriString = [NSString stringWithFormat:@"%@%@", uriBase, stationId];
        [_webView setMainFrameURL:uriString];
    } else if ((currentItem != nil) && (status == 1)) {
        // To pause.
        status = 0;
        [_webView setMainFrameURL:@"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id="];
    }
}

// ======================================================================
// Mainmenu :: Choose station.
// ======================================================================
- (IBAction)tuning:(id)sender
{
    int tag_value = (int)[sender tag];
    // Uncheck selected menu of the station.
    // Check menu of the station selected.
    [currentItem setState:NSOffState]; currentItem = sender;
    [sender setState:NSOnState];
    status = 1;
    // Change station.
    NSString *stationKey = [[NSNumber numberWithUnsignedInt: tag_value] stringValue];
    NSString *stationId = [dic objectForKey:stationKey];
    NSString *uriBase = @"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id=";
    NSString *uriString = [NSString stringWithFormat:@"%@%@", uriBase, stationId];
    [_webView setMainFrameURL:uriString];
    [_menuPlaying setTitle: [NSString stringWithFormat:@"%@ を再生中...", [currentItem title]]];
}

// ======================================================================
// Mainmenu :: Open radiko.jp or custom radio guide.
// ======================================================================
- (IBAction)openRadioGuide:(id)sender
{
    NSURL *url;
    if ([radioGuideMethod isEqualToString: @"custom"]) {
        url = [NSURL URLWithString: radioGuideURLString];
    } else {
        url = [NSURL URLWithString:@"http://radiko.jp/"];
    }
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}

// ======================================================================
// Preference :: Set if menu is shown based on preference.
// ======================================================================
- (IBAction)toggleIfMenuShown:(id)sender
{
    NSButton *button = sender;
    NSString *area;
    if ([button state] == NSOnState) {
        switch([sender tag]){
            case 0:
                [_menuHokkaido setHidden:NO];
                area = @"Hokkaido";
                break;
            case 1:
                [_menuKanto setHidden:NO];
                area = @"Kanto";
                break;
            case 2:
                [_menuHokuriku setHidden:NO];
                area = @"Hokuriku";
                break;
            case 3:
                [_menuChubu setHidden:NO];
                area = @"Chubu";
                break;
            case 4:
                [_menuKinki setHidden:NO];
                area = @"Kinki";
                break;
            case 5:
                [_menuChugoku setHidden:NO];
                area = @"Chugoku";
                break;
            case 6:
                [_menuKyushu setHidden:NO];
                area = @"Kyushu";
                break;
            case 7:
                [_menuZenkoku setHidden:NO];
                area = @"Zenkoku";
                break;
        }
    } else {
        switch([sender tag]){
            case 0:
                [_menuHokkaido setHidden:YES];
                area = @"Hokkaido";
                break;
            case 1:
                [_menuKanto setHidden:YES];
                area = @"Kanto";
                break;
            case 2:
                [_menuHokuriku setHidden:YES];
                area = @"Hokuriku";
                break;
            case 3:
                [_menuChubu setHidden:YES];
                area = @"Chubu";
                break;
            case 4:
                [_menuKinki setHidden:YES];
                area = @"Kinki";
                break;
            case 5:
                [_menuChugoku setHidden:YES];
                area = @"Chugoku";
                break;
            case 6:
                [_menuKyushu setHidden:YES];
                area = @"Kyushu";
                break;
            case 7:
                [_menuZenkoku setHidden:YES];
                area = @"Zenkoku";
                break;
        }

    }
    [userDefaults setInteger:[button state] forKey: area];
    [userDefaults synchronize];
}

// ======================================================================
// Preference :: Toggle preference panel / about panel.
// ======================================================================
- (IBAction)togglePrefWindowPanels:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [_generalPanel setHidden: false];
            [_aboutPanel setHidden: true];
            break;
        case 2:
            [_generalPanel setHidden: true];
            [_aboutPanel setHidden: false];
            break;
    }
}

// ======================================================================
// Preference :: Setting radio guide to use.
// ======================================================================
- (IBAction)setRadioGuideMethodAndURL:(id)sender
{
    radioGuideURLString = [_radioGuideURL stringValue];

    if ([[_radioGuide selectedCell] tag] == 2) {
        radioGuideMethod = @"custom";
    } else {
        radioGuideMethod = @"radiko";
    }
    [userDefaults setValue:radioGuideMethod forKey:@"Guide"];
    [userDefaults setValue:radioGuideURLString forKey:@"CustomURL"];
}


// ======================================================================
// Preference :: Open GitHub.
// ======================================================================
- (IBAction)openGitHub:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://github.com/nobu417/Raditunes"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

@end
