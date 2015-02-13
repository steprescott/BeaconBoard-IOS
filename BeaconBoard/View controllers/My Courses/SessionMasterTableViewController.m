//
//  SessionMasterTableViewController.m
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "SessionMasterTableViewController.h"
#import "SessionDetailTableViewController.h"
#import "ContextManager.h"
#import "DataSynchroniser.h"

@interface SessionMasterTableViewController ()

@property (nonatomic, strong) Session *selectedSession;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SessionMasterTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        self.managedObjectContext = [ContextManager mainContext];
        self.searchingEnabled = NO;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"dd/MM/YYYY";
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
    
    self.navigationController.title = @"Module Sessions";
    
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
    NSFetchRequest *request = [Session sqk_fetchRequest];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lesson.name" ascending:YES]];
    
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"module.moduleID == %@", self.selectedModule.moduleID];
    
    if(searchString)
    {
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"lesson.name CONTAINS[cd] %@", searchString];
        request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[filterPredicate, searchPredicate]];
    }
    else
    {
        request.predicate = filterPredicate;
    }
    
    return request;
}

#pragma mark - UITableViewDataSource

- (NSString *)sectionKeyPathForSearchableFetchedResultsController:(SQKFetchedTableViewController *)controller
{
    return @"scheduledStartDate";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Session *session = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    return [self.dateFormatter stringFromDate:session.scheduledStartDate];
}

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
    Session *session = [fetchedResultsController objectAtIndexPath:indexPath];
    theCell.textLabel.text = session.lesson.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedSession = (Session *)[[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showSession" sender:self];
    UINavigationController *detailNavigationController = [self.splitViewController.viewControllers lastObject];
    detailNavigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showSession"])
    {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        SessionDetailTableViewController *currentSessionTableViewController = (SessionDetailTableViewController *)navigationController.topViewController;
        currentSessionTableViewController.currentSession = self.selectedSession;
    }
}

@end
