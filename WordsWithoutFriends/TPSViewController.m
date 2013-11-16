//
//  TPSViewController.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "TPSViewController.h"

@interface TPSViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *partOfSpeechLabel;

@end

@implementation TPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wordLabel.text = self.wordRecord[@"word"];
    self.partOfSpeechLabel.text = self.wordRecord[@"partOfSpeech"];

}

@end
