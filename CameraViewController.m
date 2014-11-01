//
//  CameraViewController.m
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import "CameraViewController.h"
#import "BlockView.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface CameraViewController ()


@end

@implementation CameraViewController

@synthesize blockArray;
@synthesize debuggingMode;
@synthesize emptyBlock;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //If unfamiliar with parse these are a part of their framework and you can set the users to have a friend relation and be able to access their friends list basically.
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    self.recipients = [[NSMutableArray alloc] init];
    
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //The query accesses all the friends from the list on friend array which is a part of the friendrelation
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
        else{
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
    
    if(self.image == nil && [self.videoFilePath length] == 0){
        //This set Opacity is unneccessary i was going to add some stuff to the actual image picker like you can change the grid amount and maybe write a message or something. However i didnt have time.
        [self.view.layer setOpacity:100];
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
       
        //If you want to send videos eventually
        //self.imagePicker.videoMaximumDuration = 10;
        //
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        self.imagePicker.showsCameraControls = YES;
        
        
        
        
        
        
        
        if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
           
            
        }
        else{
            //Goes to this only if something goes wrong with your camera you can take a photo from your library to send it instead.
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        
        
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
      
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
}
//These pragma marks are used just for navigation purposes for myself.
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //different style for the table view:
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 50;
    [tableView setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"newBackground.jpg"]]];
    // Return the number of rows in the section.
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = ([UIColor colorWithRed:107.0/256.0 green:180.0/256.0 blue:190.0/256.0 alpha:1.0]).CGColor;
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    if([self.recipients containsObject:user.objectId]){
        //There is still an issue with sending a message to a friend the checkmark doesnt appear right away. It only appears after you send it to like a couple people. Will need to fix this
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
      
        [self.recipients addObject:user.objectId];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.recipients removeObject:user.objectId];
    }
   
}

#pragma mark - Exiting Camera

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self.tabBarController setSelectedIndex:0];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //a photo was taken or selected
        
       
            self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
      if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
            //save the image
           
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = NO;
            
            self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
          
            
        }
        
    }
    else{
        //video taken
        /*
        self.videoFilePath = CFBridgingRelease([[info objectForKey:UIImagePickerControllerMediaURL] path]);
        if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
            //save the video
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)){
            UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil);
            }
        }*/
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Buttons



- (IBAction)cancel:(id)sender {
    [self reset];
    
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)send:(id)sender {
    if(self.image == nil && [self.videoFilePath length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Try Again" message:@"Please capture or select a photo/video" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
    else{
        [self uploadMessage];
        
        [self.tabBarController setSelectedIndex:0];
    }
}

#pragma mark - upload Message
- (void)reset {
    //this is called only After the message has been sent
    self.image = nil;
    
    //self.videoFilePath = nil;
    
    [self.recipients removeAllObjects];
}

- (void)uploadMessage{
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    if(self.image != nil){
        //This image to resizeImage originally i was going to resize it right away but inside the resizeImage method there is another, I set the width and height to be a bit smaller than the smallest iphone screen, just for testing purposes again. Will change eventually to fit with new standards.
        UIImage *newImage = [self resizeImage:self.image toWidth:320.0f andHeight:400.0f];
        NSLog(@"height: %f width: %f",newImage.size.height,newImage.size.width);
        
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"image";
    }
    else{
        //FOR VIDEO DATA
        /*
        fileData = [NSData dataWithContentsOfFile:self.videoFilePath];
        fileName = @"video.mov";
        fileType = @"video";
         */
    }
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if(error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Please try sending message again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alertView show];
        }
        else{
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey:@"file"];
            [message setObject:fileType forKey:@"fileType"];
            [message setObject:self.recipients forKey:@"recipientIds"];
            [message setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
            [message setObject:[[PFUser currentUser] username] forKey:@"senderName"];
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Please try sending message again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    
                    [alertView show];
                }
                else{
                    [self reset];
                }
            }];
        }
    }];
    //check if image/video
    //upload file
    //message details
 
    
}


//Scramble here...
- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height{
    //SPLICING IMAGE INTO MULTIPLE IMAGES USING NXN ARRAY MATRIX
    
    //I can set a different amount of rows/columns if we want to make it more challenging etc. for testing purposes i only did a 4X4 grid:
    rows = 4;
    cols = 4;
    numBlocks = rows * cols;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numBlocks];
    imageWidth = width;
     imageHeight = height;
     image = [self resizeImageIfNeeded:image width:imageWidth height:imageHeight];
     blockWidth = imageWidth / cols;
     blockHeight = imageHeight / rows;
    int x = 0;
    int y = 0;
    int count = 0;
    int i = 1;
    //This is code that i had to look up so i could make a list of random Non repeating numbers
    //slightly changed it so that i could add my own things to it.
    NSMutableArray *numbers = [NSMutableArray new];
    BOOL addElement = YES;
    int limit = 16; // Range to 16
    int numElem = 16; // Number of elements
    do
    {
        int ranNum = (arc4random() % limit) +1;
        if ([numbers count] < numElem) {
            for (NSNumber *oneNumber in numbers) {
                addElement =([oneNumber intValue] != ranNum) ? YES:NO;
                if (!addElement) break;
            }
            if (addElement) [numbers addObject:[NSNumber numberWithInt:ranNum]];
        } else {
            break;
        }
    } while (1);
    NSLog(@"%@",numbers);
    CGRect blockFrame;
    NSNumber *randomNum;
    BlockView *block;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 65.0, 320.0, 400.0)];
    
    NSLog(@"ImageSize: %f %f",image.size.height,image.size.height);
    //The start of the image:
    
    UIGraphicsBeginImageContext(image.size);
    //Setting up my array of images
    for(int r = 0; r < rows; r++)
    {
        
        x = 0;
        for(int c = 0; c < cols; c++)
        {
            
        //THIS IS WHERE YOU RANDOMIZE IT
            randomNum = [numbers objectAtIndex:i-1];
            NSLog(@"%i",i);
            NSLog(@"%ld",(long)[randomNum integerValue]);
            //each of this next part determined which position a section of the image would go in.
            // the blockWidth and height were determined beforehand and set to a specific range depending on how many rows/columns you want. I set it to a 4X4 grid, but have an idea how to set up a larger grid or smaller depeding on what user wants.
            if([randomNum integerValue] == 1){
                blockFrame = CGRectMake(0, 0, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 2){
                blockFrame = CGRectMake(blockWidth, 0, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 3){
                blockFrame = CGRectMake(blockWidth*2, 0, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 4){
               
                blockFrame = CGRectMake(blockWidth*3, 0, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 5){
                blockFrame = CGRectMake(0, blockHeight, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 6){
                
                blockFrame = CGRectMake(blockWidth, blockHeight, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 7){
                blockFrame = CGRectMake(blockWidth*2, blockHeight, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 8){
                
                blockFrame = CGRectMake(blockWidth*3, blockHeight, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 9){
                
                
                blockFrame = CGRectMake(0, blockHeight*2, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 10){
                
                blockFrame = CGRectMake(blockWidth, blockHeight*2, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 11){
                blockFrame = CGRectMake(blockWidth*2, blockHeight*2, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 12){
                blockFrame = CGRectMake(blockWidth*3, blockHeight*2, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 13){
                blockFrame = CGRectMake(0, blockHeight*3, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 14){
                blockFrame = CGRectMake(blockWidth, blockHeight*3, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 15){
                blockFrame = CGRectMake(blockWidth*2, blockHeight*3, blockWidth, blockHeight);
            }
            if([randomNum integerValue] == 16){
                blockFrame = CGRectMake(blockWidth*3, blockHeight*3, blockWidth, blockHeight);
            }
            
            
            block = [[BlockView alloc] initWithFrame:blockFrame id:count showId:self.debuggingMode];
           
            if([randomNum integerValue] == 1){
                 block.originalPosition = CGPointMake(0, 0);
              block.currentPosition = CGPointMake(0, 0);
            }
            if([randomNum integerValue] == 2){
                block.originalPosition = CGPointMake(0, 1);
               block.currentPosition = CGPointMake(0, 1);
            }
            if([randomNum integerValue] == 3){
                block.originalPosition = CGPointMake(0, 2);
                     block.currentPosition = CGPointMake(0, 2);
            }
            if([randomNum integerValue] == 4){
                block.originalPosition = CGPointMake(0, 3);
                  block.currentPosition = CGPointMake(0, 3);
            }
            if([randomNum integerValue] == 5){
                block.originalPosition = CGPointMake(1, 0);
                     block.currentPosition = CGPointMake(1, 0);
            }
            if([randomNum integerValue] == 6){
                block.originalPosition = CGPointMake(1, 1);
                block.currentPosition = CGPointMake(1, 1);
            }
            if([randomNum integerValue] == 7){
                block.originalPosition = CGPointMake(1, 2);
                block.currentPosition = CGPointMake(1, 2);
            }
            if([randomNum integerValue] == 8){
                block.originalPosition = CGPointMake(1, 3);
                block.currentPosition = CGPointMake(1, 3);
            }
            if([randomNum integerValue] == 9){
                block.originalPosition = CGPointMake(2, 0);
                block.currentPosition = CGPointMake(2, 0);
            }
            if([randomNum integerValue] == 10){
                block.originalPosition = CGPointMake(2, 1);
                block.currentPosition = CGPointMake(2, 1);
            }
            if([randomNum integerValue] == 11){
                block.originalPosition = CGPointMake(2, 2);
                block.currentPosition = CGPointMake(2, 2);
            }
            if([randomNum integerValue] == 12){
                block.originalPosition = CGPointMake(2, 3);
                block.currentPosition = CGPointMake(2, 3);
            }
            if([randomNum integerValue] == 13){
                block.originalPosition = CGPointMake(3, 0);
              block.currentPosition = CGPointMake(3, 0);
            }
            if([randomNum integerValue] == 14){
                block.originalPosition = CGPointMake(3, 1);
                block.currentPosition = CGPointMake(3, 1);
            }
            if([randomNum integerValue] == 15){
                block.originalPosition = CGPointMake(3, 2);
                block.currentPosition = CGPointMake(3, 2);
            }
            if([randomNum integerValue] == 16){
                block.originalPosition = CGPointMake(3, 3);
                block.currentPosition = CGPointMake(3, 3);
            }
            
            
            //if I want to put a blank spot I decided to do it where you tap two tiles and swap but i also tried where you swipe the tiles and put it in as part of my BlockView
            /*if(count == (numBlocks-1))
            {
               self.emptyBlock = block;
             
                break;
            }*/
           
            
            block.imageView.image = [self sliceUpImage:image frame:blockFrame];
            
            block.layer.borderColor = [UIColor purpleColor].CGColor;
            [view addSubview:block];
            [array addObject:block];
     
            
            x += blockWidth;
            count++;
            [image drawInRect:blockFrame];
            if(i !=16){
            i++;
            }
        }
        y += blockHeight;
        
        
    }
    self.blockArray = array;
    
    //SHUFFLIN
   
    [self setPuzzleToInitialState];
    //adds the new puzzle to the view and then we return the image from the layer context to send.
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
   
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
  
    UIGraphicsEndImageContext();
   
    return img;
    
    
    
}
- (void)setPuzzleToInitialState
{
        //initial state of puzzle. Dont need to have the animation but it works.
    [UIView animateWithDuration:0.2f animations:^{
        int x = 0;
        int y = 0;
        int count = 0;
        int long bound = [self.blockArray count];
        for(int r = 0; r < rows; r++)
        {
            x = 0;
            for(int c = 0; c < cols; c++)
            {
                BlockView *block = nil;
                // if the last block is the empty block and not in the blockArray. This is only in the case where we have the missing block. But again not necessary because i changed it.
                if(count < bound)
                    block = [self.blockArray objectAtIndex:count];
                else
                    block = self.emptyBlock;
                CGRect blockFrame = CGRectMake(x, y, blockWidth, blockHeight);
                block.originalPosition = CGPointMake(c, r);
                block.currentPosition = CGPointMake(c, r);
                block.moveToPosition = CGPointZero;
                block.frame = blockFrame;
                x += blockWidth;
                count++;
            }
            y += blockHeight;
        }
    }];
}
//This makes a seperate image for each section of image:
- (UIImage *)sliceUpImage:(UIImage *)aImage frame:(CGRect)aFrame
{
    CGImageRef ref = CGImageCreateWithImageInRect(aImage.CGImage, aFrame);
    UIImage *image = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return image;
}
//I Resized the image so that i could put it on any phone size/type.
- (UIImage *)resizeImageIfNeeded:(UIImage *)aImage width:(CGFloat)aWidth height:(CGFloat)aHeight
{
    //if already the right size:
    if(aImage.size.width == aWidth && aImage.size.height == aHeight)
        return aImage;
    //else:
    CGSize newSize = CGSizeMake(aWidth, aHeight);
    UIGraphicsBeginImageContext(newSize);
    [aImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
