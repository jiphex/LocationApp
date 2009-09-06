//
//  LocationAppAppDelegate.m
//  LocationApp
//
//  Created by James Hannah on 30/08/2009.
//  Copyright 2009 James Hannah. All rights reserved.
//

#import "LocationAppAppDelegate.h"

@implementation LocationAppAppDelegate

@synthesize window;

- (id) init {
	defaults = [NSUserDefaultsController sharedUserDefaultsController];
	return self;
}

- (void)awakeFromNib {
	mapwebvdelegate = [[LocationAppMapDelegate alloc] initWithWebViewAndSetDelegate:mapWebView];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSAlert *noLocationServicesAlert;
	clm = [CLLocationManager new];
	[clm setDelegate:self];
	clm.desiredAccuracy = kCLLocationAccuracyBest;
	[clm startUpdatingLocation];
	if(![clm locationServicesEnabled]) {
		noLocationServicesAlert = [NSAlert alertWithMessageText:@"Location services needs to be enabled to allow this app to function!" 
												  defaultButton:@"Ok" 
												alternateButton:nil 
													otherButton:nil 
									  informativeTextWithFormat:nil];
		[noLocationServicesAlert runModal];
	}
	isZoomed = [window isZoomed];
}

- (IBAction) updateWindowWithLocation: sender {
	CLLocation *loc = [clm location];
	NSLog(@"Current accuracy is h:%f v:%f", [loc horizontalAccuracy], [loc verticalAccuracy]);
	NSLog(@"Reported speed is %f", [loc speed]);
	CLLocationCoordinate2D whereiam = loc.coordinate;
	[latLabel setStringValue:[NSString stringWithFormat:@"%f", whereiam.latitude]];
	[longLabel setStringValue:[NSString stringWithFormat:@"%f", whereiam.longitude]];
	[accuracyLabel setStringValue:[NSString stringWithFormat:@"%F meters", [loc horizontalAccuracy]]];
	// Now update the web view
	[mapwebvdelegate displayMapOfLatitude:[NSNumber numberWithDouble:whereiam.latitude] Longtitude:[NSNumber numberWithDouble:whereiam.longitude]];
	NSLog(@"Update done...");
	NSLog(@"RMOR is %@", [[defaults values] valueForKey:@"redisplayMapOnResize"]);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	[updateLocationButton setEnabled:NO];
	NSAlert *locationManagerErrorAlert = [NSAlert alertWithMessageText:@"Location services needs to be enabled!" 
											  defaultButton:@"Ok" 
											alternateButton:nil 
												otherButton:nil 
								  informativeTextWithFormat:@"Please relaunch the application and select \"Ok\" when prompted for access to Location data."];
	[locationManagerErrorAlert runModal];
}

- (void)windowDidEndLiveResize:(NSNotification *)notification {
	[mapwebvdelegate redisplayMap];
}

// We actually catch window resizes above, this is to catch window "zoom"
- (void)windowDidResize:(NSNotification *)notification {
	BOOL newZoomState = [window isZoomed];
	if(newZoomState != isZoomed) {
		// Then we've been zoomed, redraw the map
		[mapwebvdelegate redisplayMap];
	}
	isZoomed = newZoomState;
}


// Always redisplay the map when the option is changed, if it's been changed to no then that'll
// get caught and the map won't be redisplayed anyway.
- (IBAction) resizeOptionCheckboxClicked: sender {
	[mapwebvdelegate redisplayMap];
}

@end
