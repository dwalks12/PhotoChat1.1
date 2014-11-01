//
//  EditFriendsViewController.m
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import "EditFriendsViewController.h"


@interface EditFriendsViewController ()

@end

@implementation EditFriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
        else{
            self.YourFriends = objects;
            [self.tableView reloadData];
        }
    }];

   
  
  
    
    self.currentUser = [PFUser currentUser];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"newBackground.jpg"]]];
    [tableView setSeparatorColor:[UIColor clearColor]];
    // Return the number of rows in the section.
    return [self.YourFriends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    cell.textLabel.text = LookForName;
    NSLog(@"cell Label: %@",cell.textLabel.text);
    //
    
    
    

  
  
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = ([UIColor colorWithRed:107.0/256.0 green:180.0/256.0 blue:190.0/256.0 alpha:1.0]).CGColor;
    
    
    
    
   
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
    }];
    }


-(BOOL)isFriend:(PFUser *)user {
    for(PFUser *friend in self.friends){
        if([friend.objectId isEqualToString:user.objectId]){
            return YES;
        }
    }
    return NO;
}
    
- (IBAction)DoneSearch:(id)sender {
    
    NSString *SearchedPlayer = [self.TextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@",SearchedPlayer);
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:SearchedPlayer];
    self.YourFriends = [query findObjects];
    if (self.YourFriends.count > 0) {
        
        PFUser *userFound = self.YourFriends.lastObject;
        LookForName = userFound.username;
        PFRelation *relation = [[PFUser currentUser] relationForKey:@"friendsRelation"];
        [relation addObject:userFound];
        [[PFUser currentUser] saveInBackground];
       
    }
    [self.tableView reloadData];
   
}
@end
