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

//6
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //7
    //Foward background invocation from remote notification
    if([userInfo[@"aps"][@"content-available"] boolValue])
    {
        [self application:application performFetchWithCompletionHandler:completionHandler];
    }
    
    //Be careful this won't fire up your app if the user kill it from the app switcher
    //http://stackoverflow.com/questions/19068762/ios-7-background-fetch-by-push-notification-will-ios-launch-my-app-if-it-is-no
}

@end
