//
//  EditFriendsViewController.h
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsViewController : UITableViewController
{
    NSString *username;
    NSString *LookForName;
}

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *friends;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SearchForFriend;
@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *YourFriends;

-(BOOL)isFriend:(PFUser *)user;
@property (strong, nonatomic) IBOutlet UITextField *TextField;

- (IBAction)DoneSearch:(id)sender;

@end
