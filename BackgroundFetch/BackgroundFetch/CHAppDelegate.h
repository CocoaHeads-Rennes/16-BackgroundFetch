//
//  CHAppDelegate.h
//  BackgroundFetch
//
//  Created by David Bonnet on 04/02/2014.
//  Copyright (c) 2014 David Bonnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHDishesController;

@interface CHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow              *window;
@property (strong, nonatomic) CHDishesController    *dishesController;

@end
