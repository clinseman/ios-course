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

// we are creating an annonymous category to store our 'private' properties
// and methods
@interface ExerciseTableViewController ()

// liker our search results
@property (nonatomic, strong) NSArray *searchResults;

// filter our data based on our search text
- (void)filterContentForSearchText:(NSString *)searchText;

@end

@implementation ExerciseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
            // ask our Exercise Repository to generate 30 random exercises
            // when using 'real' data our repo would get the exercises from the web, or eslewhere
            [[ExerciseRepository sharedRepository] getRandomExercises:30];
            
            // set the title for this view controller so the user can see it on the NavBar
            self.title = @"Exercises";
            
            // Update the text to display when this controller is the secon most top one
            // Uncomment it, and click on an exercise to see the differnce :)
            UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
            [[self navigationItem] setBackBarButtonItem: newBackButton];
            
        }
        return self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // when this view first loads, scroll it a bit so we don't see the search bar
    [self.tableView setContentOffset:CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height) animated:NO];
    
    // set the right button to be the edit button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // and the left button to be a 'settings' button by telling it to use
    // the settings.png and setting the action to be the actionHelp method
    // ⌘ click on actionHelp to see how it's implemented
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"]
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(actionHelp:)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // tell our table views to releod any data that they're displaying
    // you could put a break point here, to see how often this is called, and when
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

// filter our data based on our search text
- (void)filterContentForSearchText:(NSString *)searchText
{
    // create a copy of all our data, and store it in our searchResults property
    self.searchResults = [[ExerciseRepository sharedRepository].data copy];
    
    // then filter the results based on the users search term
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self.name contains[c] %@", searchText];
    self.searchResults = [self.searchResults filteredArrayUsingPredicate:searchPredicate];
}

// called when our 'settings' button is pressed
- (void)actionHelp:(id)sender
{
    // Create an instance of our HelpViewController
    HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    
    // make sure we are the delegate so we can handle the 'done' button press
    helpViewController.delegate = self;
    
    // present it modally for the user to see
    [self.navigationController presentModalViewController:helpViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections in out data
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section
    // we only have one section, so this is just the amount of data items we have.
    
    // if the search table view is displayed use the search results
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    
    // otherwise use the entire data set.
    return [[ExerciseRepository sharedRepository].data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // It's quicker to reuse a cell than it is to create one, so try and dequeue one before initing a new one
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // no cells are available for reuse, so we have to create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to display an exercise from out data source
    Exercise *exercise;
    
    // if we're displaying the search table, use our search results
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        exercise = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        // otherwise use the entire data set
        exercise = [[ExerciseRepository sharedRepository].data objectAtIndex:indexPath.row];
    }
    
    // update the cell's text lable
    cell.textLabel.text = exercise.name;
    
    // and set the accessoryType to be a discloure
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // we are deleting an entry
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[ExerciseRepository sharedRepository] removeExerciseAtIndex:indexPath.row];
        
        // and remove it from the tableView
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        // we are not creating Exercises, but if we did, we'd do it here
    }   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    // An exercise object was selected, need to display it to the user
    
    // First create a view controller for it
    ExerciseViewController *exerciseViewController = [[ExerciseViewController alloc] init];
    
    Exercise *exercise;
    
    // Get the right exercise, depending on if it's a search result, or from the main list
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        exercise = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        exercise = [[ExerciseRepository sharedRepository].data objectAtIndex:indexPath.row];
    }
    
    // tell our new vie controller which exercise to use
    exerciseViewController.exercise = exercise;
    
    // tell our nav controller to display out Exercise View Controller (push it on the stack)
    [self.navigationController pushViewController:exerciseViewController animated:YES];
    
}

#pragma mark - UISearchDisplayController
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // handle the user typing in stuff while searching
    // filter the results with our custom filter method
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark - HelpViewController Delegate
// implement the HelpViewController Delegate method
-(void)helpViewControllerDidFinish:(HelpViewController *)controller
{
    // the 'done' button was pressed, so tell the nav controller to dissmiss the modal help view controller
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
