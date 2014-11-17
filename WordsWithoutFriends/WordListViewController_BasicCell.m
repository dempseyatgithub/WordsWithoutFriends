//
//  WordListViewController_BasicCell.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "WordListViewController_BasicCell.h"
#import "WordDetailViewController.h"

@interface WordListViewController_BasicCell ()

@end

/* As of iOS 8.1, the easiest way to enable Dynamic Type for a table is to:
    
    1. Use one of the built-in table cell styles
    2. Set an estimated row height and
    3. Set the rowHeight of the table to UITableViewAutomaticDimension
 
 Note that as of iOS 8.1, any font customization you do to a built-in table cell style will be overridden if the user changes their preferred type size while your application is running.
 */

@implementation WordListViewController_BasicCell

- (void)viewDidLoad {
    [super viewDidLoad];

    // We don't want the default deselection animation, we handle it ourselves in -viewWillAppear
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Makes the table view automatically calculate row heights
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addCellDeselectionAnimation];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *wordRecord = [self.words objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    cell.textLabel.text = wordRecord[@"word"];
    cell.detailTextLabel.text = wordRecord[@"partOfSpeech"];

    return cell;
}

#pragma mark -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *wordRecord = [self.words objectAtIndex:indexPath.row];
    
    WordDetailViewController *vc = segue.destinationViewController;
    vc.wordRecord = wordRecord;
}

#pragma mark -

// This will animate the deselection of the selected table row along with the standard animation
- (void)addCellDeselectionAnimation {
    
    UITableView *tableView = self.tableView;
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    
    if (indexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        // In this case, I am appearing, but am already in a parent view controller
        if (self.transitionCoordinator && self.transitionCoordinator.initiallyInteractive && !self.isBeingPresented && !self.isMovingToParentViewController) {
            
            [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                
                [cell setSelected:NO animated:YES];
                
            } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                if (context.isCancelled) {
                    // Reverse the cell selection process
                    [cell setSelected:YES animated:NO];
                } else {
                    // Tell the table about the selection
                    [tableView deselectRowAtIndexPath:indexPath animated:NO];
                }
            }];
            
        } else {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

@end
