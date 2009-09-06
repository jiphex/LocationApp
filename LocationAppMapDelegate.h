//
//  LocationAppMapDelegate.h
//  LocationApp
//
//  Created by James Hannah on 05/09/2009.
//  Copyright 2009 James Hannah. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/Webkit.h>

@interface LocationAppMapDelegate : NSObject {
	WebView *mapWebView;
	NSUserDefaultsController *defaults;
}

- (id) initWithWebViewAndSetDelegate:(WebView*) theView;
- (void) displayMapOfLatitude:(NSNumber*)latitude Longtitude:(NSNumber*)longtitude;
- (void) redisplayMap;

- (void)webView:(WebView *)senderdidFailLoadWithError:(NSError *)errorforFrame:(WebFrame *)frame;
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;

@end
