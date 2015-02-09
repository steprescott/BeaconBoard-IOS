//
//  CourseMasterTableViewController.m
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "CourseMasterTableViewController.h"
#import "ModuleMasterTableViewController.h"
#import "ContextManager.h"
#import "DataSynchroniser.h"

@interface CourseMasterTableViewController () <UISplitViewControllerDelegate>

@property (nonatomic, strong) Course *selectedCourse;

@end

@implementation CourseMasterTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        self.managedObjectContext = [ContextManager mainContext];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.splitViewController.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.title = @"My Courses";
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
    UINavigationController *detailNavigationController = [self.splitViewController.viewControllers lastObject];
    detailNavigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
}

- (void)refresh:(id)sender
{
    [self.refreshControl beginRefreshing];
    [DataSynchroniser syncData];
    [self.refreshControl endRefreshing];
}

- (NSFetchRequest *)fetchRequestForSearch:(NSString *)searchString
{
    NSFetchRequest *request = [Course sqk_fetchRequest];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]];
    
    if(searchString)
    {
        request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchString];
    }
    
    return request;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicCell"
                                                                 forIndexPath:indexPath];
    
    [self fetchedResultsController:[self fetchedResultsControllerForTableView:tableView]
                     configureCell:cell
                       atIndexPath:indexPath];
    return cell;
}

- (void)fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                   configureCell:(UITableViewCell *)theCell
                     atIndexPath:(NSIndexPath *)indexPath
{
    Course *course = [fetchedResultsController objectAtIndexPath:indexPath];
    theCell.textLabel.text = course.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSFetchedResultsController *test = [self fetchedResultsControllerForTableView:tableView];
    self.selectedCourse = (Course *)[test objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showModules" sender:self];
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showModules"])
    {
        ModuleMasterTableViewController *moduleMasterTableViewController = (ModuleMasterTableViewController *)segue.destinationViewController;
        moduleMasterTableViewController.selectedCourse = self.selectedCourse;
    }
}

@end
