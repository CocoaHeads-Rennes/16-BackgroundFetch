//
//  CHAppDelegate.m
//  BackgroundFetch
//
//  Created by David Bonnet on 04/02/2014.
//  Copyright (c) 2014 David Bonnet. All rights reserved.
//

#import "CHAppDelegate.h"
#import "CHDishesController.h"

@implementation CHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //1
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.dishesController = [CHDishesController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.dishesController];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//2
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //3
    if (self.dishesController)
    {
        [self.dishesController loadNewContentWithCompletionHandler:completionHandler];
    }
    else
    {
        NSLog(@"Dishes controller not available");
        completionHandler(UIBackgroundFetchResultFailed);
    }
}

@end
