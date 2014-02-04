//
//  CHDishesController.m
//  BackgroundFetch
//
//  Created by David Bonnet on 04/02/2014.
//  Copyright (c) 2014 David Bonnet. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Imports

#import "CHDishesController.h"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Types

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Defines & Constants

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Macros

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Interface

@interface CHDishesController ()

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Outlets

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Properties
@property (nonatomic, strong) NSArray          *dishesDb;
@property (nonatomic, strong) NSMutableArray   *dishes;

@property (nonatomic)         NSInteger         numberOfNewPosts;

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation CHDishesController

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Setup & Teardown

-(void)commonInitCHDishesController
{
    // Your common initialization code here
    self.dishesDb = @[@"Ramequins fondants au chocolat",
                      @"Tiramisu",
                      @"Saumon à la mousse de courgettes",
                      @"Tarte au citron meringuée",
                      @"Le crumble aux pommes du chat qui tousse",
                      @"Blanquette de veau",
                      @"Véritable moelleux au chocolat",
                      @"Gâteau au yaourt",
                      @"Galette des rois",
                      @"Filet mignon en croûte",
                      @"Original american cookies de mike",
                      @"Meringue pour les nuls",
                      @"Tarte chocolat - poires facile"];
    
    self.dishes = [NSMutableArray new];
    
    UIRefreshControl *refreshC = [[UIRefreshControl alloc] init];
    [refreshC addTarget:self action:@selector(loadNewDishes) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshC;
}

-(id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self commonInitCHDishesController];
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInitCHDishesController];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass Overrides

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recettes Gourmandes";
    
    // Do any additional setup after loading the view from its nib.
    [self.dishes addObject:self.dishesDb[[self getRandomNumberBetween:0 to:[self.dishesDb count] - 1]]];
}

-(void)viewDidUnload
{
	// Release any retained subviews of the main view.
    
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Perform custom tasks associated with displaying the view
}

-(void)viewDidDisappear:(BOOL)animated
{
    // Perform additional tasks associated with dismissing or hiding the view
    
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

//5
- (void)loadNewContentWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self loadNewDishes];
    if(completionHandler)
    {
        completionHandler(self.numberOfNewPosts ? UIBackgroundFetchResultNewData : UIBackgroundFetchResultNoData);
    }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions

- (void)loadNewDishes
{
    self.numberOfNewPosts = [self getRandomNumberBetween:0 to:4];
    
    NSLog(@"%d new fetched object(s)",self.numberOfNewPosts);
    for(int i = 0; i < self.numberOfNewPosts; i++)
    {
        int addPost = [self getRandomNumberBetween:0 to:(int)([self.dishesDb count]-1)];
        [self.dishes insertObject:self.dishesDb[addPost] atIndex:0];
    }
    
    [self.refreshControl endRefreshing];
    
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dishes count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identififer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.dishes[indexPath.row];
    
    if(indexPath.row < self.numberOfNewPosts)
        cell.backgroundColor = [UIColor yellowColor];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
