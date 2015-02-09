//
//  ModuleMasterTableViewController.m
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "ModuleMasterTableViewController.h"
#import "SessionMasterTableViewController.h"
#import "ContextManager.h"
#import "DataSynchroniser.h"

@interface ModuleMasterTableViewController ()

@property (nonatomic, strong) Module *selectedModule;

@end

@implementation ModuleMasterTableViewController

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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.title = @"Course Modules";
    
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
    NSFetchRequest *request = [Module sqk_fetchRequest];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SUBQUERY(courses, $i, $i.courseID == %@).@count != 0", self.selectedCourse.courseID];
    
    if(searchString)
    {
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchString];
        request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[filterPredicate, searchPredicate]];
    }
    else
    {
        request.predicate = filterPredicate;
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
    Module *module = [fetchedResultsController objectAtIndexPath:indexPath];
    theCell.textLabel.text = module.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedModule = (Module *)[[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showSessions" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showSessions"])
    {
        SessionMasterTableViewController *sessionMasterTableViewController = (SessionMasterTableViewController *)segue.destinationViewController;
        sessionMasterTableViewController.selectedModule = self.selectedModule;
    }
}

@end
