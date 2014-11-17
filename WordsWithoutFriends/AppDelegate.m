//
//  AppDelegate.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "AppDelegate.h"
#import "WordListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"WordList" withExtension:@"plist"];
    
    NSArray *wordList = [NSArray arrayWithContentsOfURL:plistURL];
    wordList = [wordList sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"word" ascending:YES]]];
    
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    
    WordListViewController *viewController = (WordListViewController *)navController.topViewController;
    
    viewController.words = wordList;
    
    return YES;
}
							
@end
