//
//  TPSWordListViewController.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "TPSWordListViewController.h"
#import "TPSViewController.h"

@interface TPSWordListViewController ()

@end

@implementation TPSWordListViewController

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
    
    TPSViewController *vc = segue.destinationViewController;
    vc.wordRecord = wordRecord;
}


@end
