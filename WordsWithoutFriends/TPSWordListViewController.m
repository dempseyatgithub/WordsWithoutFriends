//
//  TPSWordListViewController.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "TPSWordListViewController.h"
#import "TPSViewController.h"
#import "TPSSelectedBackgroundView.h"

@interface TPSWordListViewController ()

@end

@implementation TPSWordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateRowHeight];

    // We don't want the default deselection animation
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UITableView *tableView = self.tableView;
    
    // In this case, I am appearing, but am already in a parent view controller
    if (self.transitionCoordinator && self.transitionCoordinator.initiallyInteractive && !self.isBeingPresented && !self.isMovingToParentViewController) {
        
        [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            // Change the alpha of the color view only
            TPSSelectedBackgroundView *backgroundView = (TPSSelectedBackgroundView *)cell.selectedBackgroundView;
            backgroundView.colorView.alpha = 0.0;
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            if (!context.isCancelled) {
                [tableView deselectRowAtIndexPath:indexPath animated:NO];
                
                // Set alpha back for next use
                TPSSelectedBackgroundView *backgroundView = (TPSSelectedBackgroundView *)cell.selectedBackgroundView;
                backgroundView.colorView.alpha = 1.0;

            }
        }];
        
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
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
    [self updateRowHeight];
    [self.tableView reloadData];
    
}

- (void)updateRowHeight {
    NSString *contentSizeCategory = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSInteger rowHeight = [self rowHeightForContentSizeCategory:contentSizeCategory];
    self.tableView.rowHeight = rowHeight;
}

- (NSInteger)rowHeightForContentSizeCategory:(NSString *)contentSizeCategory {
    static NSDictionary *heightsByCategory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        heightsByCategory = @{UIContentSizeCategoryExtraSmall: @(44),
                              UIContentSizeCategorySmall: @(44),
                              UIContentSizeCategoryMedium: @(44),
                              UIContentSizeCategoryLarge: @(44),
                              UIContentSizeCategoryExtraLarge: @(52),
                              UIContentSizeCategoryExtraExtraLarge: @(56),
                              UIContentSizeCategoryExtraExtraExtraLarge: @(60)
                              };
    });

    NSNumber *number = heightsByCategory[contentSizeCategory];
    if (!number) number = @(60);

    return [number integerValue];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Use custom selected background view
    if (![cell.selectedBackgroundView isKindOfClass:[TPSSelectedBackgroundView class]]) {

        TPSSelectedBackgroundView *backgroundView = [[TPSSelectedBackgroundView alloc] init];
        backgroundView.colorView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
        backgroundView.separatorColor = self.tableView.separatorColor;
        cell.selectedBackgroundView = backgroundView;
    }

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
    
    TPSViewController *vc = segue.destinationViewController;
    vc.wordRecord = wordRecord;
}


@end
