//
//  JSAppDelegate.m
//  Battery Level
//
//  Created by John Szumski on 5/17/13.
//  Copyright (c) 2013 John Szumski. All rights reserved.
//

#import "JSAppDelegate.h"

@implementation JSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	self.viewController = [[UIViewController alloc] init];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
	double delayInSeconds = 10.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		
		for (int x = 0; x < 100; x++) {
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
				[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
				NSLog(@"(high) Current battery level %f", [UIDevice currentDevice].batteryLevel);
				[[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
			});
			
			[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
			NSLog(@"(main) Current battery level %f", [UIDevice currentDevice].batteryLevel);
			[[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
		}
		
	});
	
    return YES;
}

@end