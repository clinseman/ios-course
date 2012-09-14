//
//  ExerciseTableViewController.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseTableViewController.h"
#import "ExerciseRepository.h"
#import "Exercise.h"
#import "ExerciseViewController.h"
#import "HelpViewController.h"

@interface ExerciseTableViewController ()
@property (nonatomic, strong) NSArray *searchResults;

- (void)filterContentForSearchText:(NSString *)searchText;

@end

@implementation ExerciseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
            [[ExerciseRepository sharedRepository] getRandomExercises:30];
            self.title = @"Exercises";
            
            UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
            [[self navigationItem] setBackBarButtonItem: newBackButton];
            
        }
        return self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentOffset:CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height) animated:NO];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Question"]
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(actionHelp:)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)filterContentForSearchText:(NSString *)searchText
{
    self.searchResults = [[ExerciseRepository sharedRepository].data copy];
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self.name contains[c] %@", searchText];
    self.searchResults = [self.searchResults filteredArrayUsingPredicate:searchPredicate];
}

- (void)actionHelp:(id)sender
{
    HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    helpViewController.delegate = self;
    [self.navigationController presentModalViewController:helpViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    
    return [[ExerciseRepository sharedRepository].data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Exercise *exercise;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        exercise = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        exercise = [[ExerciseRepository sharedRepository].data objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = exercise.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"Section: %d", section];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[ExerciseRepository sharedRepository] removeExerciseAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    ExerciseViewController *exerciseViewController = [[ExerciseViewController alloc] init];
    
    Exercise *exercise;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        exercise = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        exercise = [[ExerciseRepository sharedRepository].data objectAtIndex:indexPath.row];
    }
    
    exerciseViewController.exercise = exercise;
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:exerciseViewController animated:YES];
    
}

#pragma mark - UISearchDisplayController
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark - HelpViewController Delegate
-(void)helpViewControllerDidFinish:(HelpViewController *)controller
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
