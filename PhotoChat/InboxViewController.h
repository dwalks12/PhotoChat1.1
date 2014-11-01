//
//  InboxViewController.h
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface InboxViewController : UITableViewController
@property (nonatomic, strong)NSArray *messages;
@property (nonatomic, strong)PFObject *selectedMessage;
@property (nonatomic, strong)MPMoviePlayerController *moviePlayer;

- (IBAction)logout:(id)sender;

@end
