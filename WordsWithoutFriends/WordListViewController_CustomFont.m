//
//  WordListViewController_CustomFont.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "WordListViewController_CustomFont.h"
#import "WordDetailViewController.h"

@interface WordListViewController_CustomFont ()

@end

@implementation WordListViewController_CustomFont

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:[UIApplication sharedApplication]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)contentSizeChanged:(NSNotification *)note {
    [self.tableView reloadData];
}

- (NSInteger)fontSizeForContentSizeCategory:(NSString *)contentSizeCategory {
    static NSDictionary *heightsByCategory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        heightsByCategory = @{UIContentSizeCategoryExtraSmall: @(9),
                              UIContentSizeCategorySmall: @(10),
                              UIContentSizeCategoryMedium: @(12),
                              UIContentSizeCategoryLarge: @(14),
                              UIContentSizeCategoryExtraLarge: @(16),
                              UIContentSizeCategoryExtraExtraLarge: @(18),
                              UIContentSizeCategoryExtraExtraExtraLarge: @(24)
                              };
    });
    
    NSNumber *number = heightsByCategory[contentSizeCategory];
    if (!number) number = @(20);
    
    return [number integerValue];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomFontWordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    
    NSDictionary *wordRecord = [self.words objectAtIndex:indexPath.row];
    
    cellLabel.text = wordRecord[@"word"];
    
    CGFloat fontSize = [self fontSizeForContentSizeCategory:[[UIApplication sharedApplication] preferredContentSizeCategory]];
    cellLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:fontSize];
    
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
