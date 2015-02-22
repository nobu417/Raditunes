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
    int *status;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // UserDefaults をロード
    userDefaults = [NSUserDefaults standardUserDefaults];
    // メニューに表示する地域の状態を復元
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

    // 設定画面のチェックボックスの状態を復元
    [_Hokkaido setState: [userDefaults integerForKey: @"Hokkaido"]];
    [_Kanto setState: [userDefaults integerForKey: @"Kanto"]];
    [_Hokuriku setState: [userDefaults integerForKey: @"Hokuriku"]];
    [_Chubu setState: [userDefaults integerForKey: @"Chubu"]];
    [_Kinki setState: [userDefaults integerForKey: @"Kinki"]];
    [_Chugoku setState: [userDefaults integerForKey: @"Chugoku"]];
    [_Kyushu setState: [userDefaults integerForKey: @"Kyushu"]];
    [_Zenkoku setState: [userDefaults integerForKey: @"Zenkoku"]];
    
    // Insert code here to initialize your application
    // plist から放送局リストを読み込み
    NSString *path = [[NSBundle mainBundle] pathForResource:@"channels" ofType:@"plist"];
    dic = [NSDictionary dictionaryWithContentsOfFile: path];
    status = 0;
    [_webView setMainFrameURL:@"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id="];
    [self refreshDarkMode];
    [self setupStatusItem];
}

- (BOOL)windowShouldClose:(id)sender
{
    [_window orderOut:sender];
    return NO;
}

- (void)setupStatusItem
{
    NSStatusBar *systemStatusBar = [NSStatusBar systemStatusBar];
    _statusItem = [systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    //[_statusItem setHighlightMode:YES];
    //[_statusItem setTitle:@"StatusBarApp"];
    //[_statusItem setImage:[NSImage imageNamed:@"icon"]];
    NSImage *image= [NSImage imageNamed:@"icon"];
    [image setTemplate:YES];
    [_statusItem setImage:image];
    [_statusItem setMenu:self.statusMenu];
}

- (void)refreshDarkMode {
    NSString *value = (__bridge NSString *)(CFPreferencesCopyValue((CFStringRef)@"AppleInterfaceStyle", kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost));
    if ([value isEqualToString:@"Dark"]) {
        self.darkModeOn = YES;
    }
    else {
        self.darkModeOn = NO;
    }
}

-(IBAction)showWindow:(id)sender
{
    [[NSApplication sharedApplication] activateIgnoringOtherApps : YES];
    [_window makeKeyAndOrderFront:_window];
    [_window orderWindow:NSWindowAbove relativeTo:0];
}

-(IBAction)showPrefWindow:(id)sender
{
    [[NSApplication sharedApplication] activateIgnoringOtherApps : YES];
    [_prefWindow makeKeyAndOrderFront:_prefWindow];
    [_prefWindow orderWindow:NSWindowAbove relativeTo:0];
}

- (IBAction)playAndPause:(id)sender
{
    if ((currentItem != nil) && (status == 0)) {
        // 再生
        status = 1;
        NSString *stationKey = [[NSNumber numberWithUnsignedInt:[currentItem tag]] stringValue];
        NSString *stationId = [dic objectForKey:stationKey];
        NSString *uriBase = @"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id=";
        NSString *uriString = [NSString stringWithFormat:@"%@%@", uriBase, stationId];
        [_webView setMainFrameURL:uriString];
    } else if ((currentItem != nil) && (status == 1)) {
        // 停止
        status = 0;
        [_webView setMainFrameURL:@"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id="];
    }
}

- (IBAction)tuning:(id)sender
{
    // 選択されていたメニューを解除して、選択中のメニューを選択したメニューにする
    [currentItem setState:NSOffState]; currentItem = sender;
    [sender setState:NSOnState];
    status = 1;
    // 放送局を切り替え
    NSString *stationKey = [[NSNumber numberWithUnsignedInt:[sender tag]] stringValue];
    NSString *stationId = [dic objectForKey:stationKey];
    NSString *uriBase = @"http://radiko.jp/player/swf/player_4.1.0.00.swf?_=2012111501&station_id=";
    NSString *uriString = [NSString stringWithFormat:@"%@%@", uriBase, stationId];
    [_webView setMainFrameURL:uriString];
    
}

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

@end
