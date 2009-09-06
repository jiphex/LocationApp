//
//  LocationAppAppDelegate.h
//  LocationApp
//
//  Created by James Hannah on 30/08/2009.
//  Copyright 2009 James Hannah. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <WebKit/WebKit.h>

#import "LocationAppMapDelegate.h"

@interface LocationAppAppDelegate : NSObject <NSWindowDelegate, NSApplicationDelegate,CLLocationManagerDelegate> {
    NSWindow *window;
	CLLocationManager *clm;
	LocationAppMapDelegate *mapwebvdelegate;
	IBOutlet NSTextField* latLabel;
	IBOutlet NSTextField* longLabel;
	IBOutlet NSTextField* distLabel;
	IBOutlet NSTextField* accuracyLabel;
	IBOutlet NSButton* updateLocationButton;
	IBOutlet WebView* mapWebView;
	BOOL isZoomed; // Tracks if window is zoomed to detect changes
	
	NSUserDefaultsController *defaults;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) updateWindowWithLocation: sender;
- (IBAction) resizeOptionCheckboxClicked: sender;

// Window delegation
- (void)windowDidEndLiveResize:(NSNotification *)notification;
- (void)windowDidResize:(NSNotification *)notification;
// Location Manager delegation
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end
