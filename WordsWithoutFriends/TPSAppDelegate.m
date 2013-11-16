//
//  TPSAppDelegate.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "TPSAppDelegate.h"
#import "TPSWordListViewController.h"

@implementation TPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"WordList" withExtension:@"plist"];
    
    NSArray *wordList = [NSArray arrayWithContentsOfURL:plistURL];
    wordList = [wordList sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"word" ascending:YES]]];
    
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    
    TPSWordListViewController *viewController = (TPSWordListViewController *)navController.topViewController;
    
    viewController.words = wordList;
    
    return YES;
}
							
@end
