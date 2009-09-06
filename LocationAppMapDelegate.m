//
//  LocationAppMapDelegate.m
//  LocationApp
//
//  Created by James Hannah on 05/09/2009.
//  Copyright 2009 James Hannah. All rights reserved.
//

#import "LocationAppMapDelegate.h"


@implementation LocationAppMapDelegate

- (id) initWithWebViewAndSetDelegate:(WebView*) theView {
	defaults = [NSUserDefaultsController sharedUserDefaultsController];
	mapWebView = theView;
	[mapWebView setUIDelegate:self];
	[mapWebView setFrameLoadDelegate:self];
	[[mapWebView mainFrame]loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mapBase" 
																														   ofType:@"html"] 
																			   isDirectory:NO]]];
	return self;
}

- (void) displayMapOfLatitude:(NSNumber*)latitude Longtitude:(NSNumber*)longtitude {
	id mapScriptObject = [mapWebView windowScriptObject];
	NSArray *callArgs = [NSArray arrayWithObjects:latitude, longtitude, nil];
	[mapScriptObject callWebScriptMethod:@"displayMapForCoords" withArguments:callArgs];
	[self redisplayMap];
}

- (void) redisplayMap {
	id mapScriptObject = [mapWebView windowScriptObject];
	if([[defaults values] valueForKey:@"redisplayMapOnResize"] == [NSNumber numberWithBool:YES]) {
		[mapScriptObject callWebScriptMethod:@"redisplayMap" withArguments: NULL];
	} else {
		NSLog(@"Not redisplaying map due to user preference");
	}
}

// Delegate methods...

- (void)webView:(WebView *)senderdidFailLoadWithError:(NSError *)errorforFrame:(WebFrame *)frame {
	NSLog(@"MapView error message: %@", errorforFrame);
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	NSLog(@"Finished loading url");
}	

@end
