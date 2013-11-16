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


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *wordRecord = [self.words objectAtIndex:indexPath.row];
    
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
