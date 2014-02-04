//
//  CHDishesController.h
//  BackgroundFetch
//
//  Created by David Bonnet on 04/02/2014.
//  Copyright (c) 2014 David Bonnet. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Imports

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Types

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Defines & Constants

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Macros

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface CHDishesController : UITableViewController

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Properties

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Instance Methods

//4
- (void)loadNewContentWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
