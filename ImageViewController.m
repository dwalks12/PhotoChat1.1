//
//  ImageViewController.m
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import "ImageViewController.h"


@interface ImageViewController ()

@end

@implementation ImageViewController



- (void)viewDidLoad//Where the Picture will be scrambled and you will have to reassemble
{
    [super viewDidLoad];
    timeCount = 75;
    tapCounter = 0;
	PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent From: %@",senderName];
    self.navigationItem.title = title;
    
   UIImage *image = self.imageView.image;
    //[self loadView:image];
   //[self getImagesFromImage:image withRow:4 withColumn:4];
    //
    NSLog(@"image Width: %f image Height: %f",image.size.width,image.size.height);
    CGFloat width = 320/4;
    CGFloat height = 400/4;
    UIView* root = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    UIImage* whole = image;
     CGFloat xPos, yPos = 0.0;
    int partId = 0;
    for (int x=0; x<4; x++) {
        xPos = 0.0;
        
        for(int y=0; y<4; y++) {
            
            if(x == 0){
            CGImageRef cgImg = CGImageCreateWithImageInRect(whole.CGImage, CGRectMake(xPos, yPos, 320/4, 400/4));
            UIImage* part = [UIImage imageWithCGImage:cgImg];
            UIImageView* iv = [[UIImageView alloc] initWithImage:part];
            
           view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 320/4, 400/4)];
                
            [view addSubview:iv];
            //[whole release];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(tap:)];
            tap.numberOfTapsRequired = 1;
            [view addGestureRecognizer:tap];
            //[tap release];
            
            view.tag = partId;
                view.layer.borderWidth = 1.0;
                view.layer.borderColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0].CGColor;
            [root addSubview:view];
            //[sView release];
            xPos += width;
            partId++;
            CGImageRelease(cgImg);
            }
            else if(x==1){
                CGImageRef cgImg = CGImageCreateWithImageInRect(whole.CGImage, CGRectMake(xPos, yPos, 320/4, 400/4));
                UIImage* part = [UIImage imageWithCGImage:cgImg];
                UIImageView* iv = [[UIImageView alloc] initWithImage:part];
                
                view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 320/4, 400/4)];
                [view addSubview:iv];
                
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(tap:)];
                tap.numberOfTapsRequired = 1;
                [view addGestureRecognizer:tap];
            
                
                view.tag = partId;
                view.layer.borderWidth = 1.0;
                view.layer.borderColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0].CGColor;
                [root addSubview:view];
              
                xPos += width;
                partId++;
                CGImageRelease(cgImg);
            }
            else if(x==2){
                CGImageRef cgImg = CGImageCreateWithImageInRect(whole.CGImage, CGRectMake(xPos, yPos, 320/4, 400/4));
                UIImage* part = [UIImage imageWithCGImage:cgImg];
                UIImageView* iv = [[UIImageView alloc] initWithImage:part];
                
               view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 320/4, 400/4)];
                [view addSubview:iv];
                //[whole release];
                
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(tap:)];
                tap.numberOfTapsRequired = 1;
                [view addGestureRecognizer:tap];
                
                
                view.tag = partId;
                view.layer.borderWidth = 1.0;
                view.layer.borderColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0].CGColor;
                [root addSubview:view];
               
                xPos += width;
                partId++;
                CGImageRelease(cgImg);
            }
            else if(x==3){
                CGImageRef cgImg = CGImageCreateWithImageInRect(whole.CGImage, CGRectMake(xPos, yPos, 320/4, 400/4));
                UIImage* part = [UIImage imageWithCGImage:cgImg];
                UIImageView* iv = [[UIImageView alloc] initWithImage:part];
                
                view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 320/4, 400/4)];
                view.backgroundColor = [UIColor clearColor];
                [view addSubview:iv];
              
                
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(tap:)];
                tap.numberOfTapsRequired = 1;
                [view addGestureRecognizer:tap];
   
                
                view.tag = partId;
                view.layer.borderWidth = 1.0;
                view.layer.borderColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0].CGColor;
                [root addSubview:view];
           
                xPos += width;
                partId++;
                CGImageRelease(cgImg);
            }
            NSLog(@"x: %i y: %i",x,y);
        }
        
        yPos += height;
        
    }
    
 
    self.view = root;
    CGRect rect = [[self view] bounds];
    
    rect.origin.y -= 65.0f;
    [[self view] setBounds:rect];
    self.view.backgroundColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0];
    UILabel *instructions = [[UILabel alloc] initWithFrame:CGRectMake(65,405, 300.0, 20.0) ];
    instructions.textColor = [UIColor whiteColor];
    instructions.backgroundColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0];
    instructions.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(20.0)];
    instructions.text = [NSString stringWithFormat:@"Tap 2 Tiles to swap"];
    [self.view addSubview:instructions];
 
    //timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 500, 200, 40)];
    //[self.view addSubview:timelabel];
    //timelabel.adjustsFontSizeToFitWidth = YES;
   [NSTimer  scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //Limited Time to do the puzzle

    
   // [NSTimer scheduledTimerWithTimeInterval:200 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
}

-(void)time{
    
    
    //timelabel.textColor=[UIColor whiteColor];
    timeCount -= 0.1;
    //timelabel.text = [NSString stringWithFormat:@" %f",timeCount];
    
    
    UILabel *scoreLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(100,430, 150.0, 43.0) ];

    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.backgroundColor = [UIColor colorWithRed:93.0/256.0 green:202.0/256.0 blue:252.0/256.0 alpha:1.0];
    scoreLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(36.0)];
    [self.view addSubview:scoreLabel];
    scoreLabel.text = [NSString stringWithFormat:@" %.2f",timeCount];

    if(timeCount <= 0){
        [self timeout];
    }
}

- (void)tap:(UITapGestureRecognizer*)gesture
{
    tapCounter++;
    NSLog(@"tapCOunt: %i",tapCounter);
    tappedView = (UIImageView *)gesture.view;
    NSLog(@"gesture view: %@",tappedView);
   
   
   // UIImageView *tmp = [UIImageView alloc];
   
    
    
    
    NSLog(@"image tap=%ld", (long)gesture.view.tag);
    //NEEDED SEVERAL CASES
    
    if(tapCounter == 1 && (long)gesture.view.tag == 0){
       
        setGestureCount = 0;
        view = gesture.view;
        
        [view setTag:0];
    
        
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 1){
        
        setGestureCount = 1;
        view = gesture.view;
        [view setTag:1];

    }
    if(tapCounter == 1 && (long)gesture.view.tag == 2){
        
        setGestureCount = 2;
        view = gesture.view;
        [view setTag:2];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 3){
        
        setGestureCount = 3;
        view = gesture.view;
        [view setTag:3];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 4){
        
        setGestureCount = 4;
        view = gesture.view;
        [view setTag:4];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 5){
        
        setGestureCount = 5;
        view = gesture.view;
        [view setTag:5];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 6){
        
        setGestureCount = 6;
        view = gesture.view;
        [view setTag:6];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 7){
        
        setGestureCount = 7;
        view = gesture.view;
        [view setTag:7];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 8){
        
        setGestureCount = 8;
        view = gesture.view;
        [view setTag:8];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 9){
        
        setGestureCount = 9;
        view = gesture.view;
        [view setTag:9];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 10){
        
        setGestureCount = 10;
        view = gesture.view;
        [view setTag:10];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 11){
        
        setGestureCount = 11;
        view = gesture.view;
        [view setTag:11];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 12){
        
        setGestureCount = 12;
        view = gesture.view;
        [view setTag:12];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 13){
        
        setGestureCount = 13;
        view = gesture.view;
        [view setTag:13];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 14){
        
        setGestureCount = 14;
        view = gesture.view;
        [view setTag:14];
    }
    if(tapCounter == 1 && (long)gesture.view.tag == 15){
        
        setGestureCount = 15;
        view = gesture.view;
        [view setTag:15];
    }
    //the case when gesture 1 is pressed.
    if(tapCounter>=2 && (long)gesture.view.tag == 0){
        tapCounter = 0;
       
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter >= 2 && (long)gesture.view.tag == 1){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
             CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 2){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 3){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 4){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
        
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 5){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
        
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 6){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
        
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 7){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
        
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 8){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
        
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 9){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 10){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 11){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 12){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 13){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 14){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
    if(tapCounter>=2 && (long)gesture.view.tag == 15){
        tapCounter = 0;
        if(setGestureCount == 0){
            prevImage = ((UIImageView *)[view viewWithTag:0]);
        }
        if(setGestureCount == 1){
            prevImage = ((UIImageView *)[view viewWithTag:1]);
        }
        if(setGestureCount == 2){
            prevImage = ((UIImageView *)[view viewWithTag:2]);
        }
        if(setGestureCount == 3){
            prevImage = ((UIImageView *)[view viewWithTag:3]);
        }
        if(setGestureCount == 4){
            prevImage = ((UIImageView *)[view viewWithTag:4]);
        }
        if(setGestureCount == 5){
            prevImage = ((UIImageView *)[view viewWithTag:5]);
        }
        if(setGestureCount == 6){
            prevImage = ((UIImageView *)[view viewWithTag:6]);
        }
        if(setGestureCount == 7){
            prevImage = ((UIImageView *)[view viewWithTag:7]);
        }
        if(setGestureCount == 8){
            prevImage = ((UIImageView *)[view viewWithTag:8]);
        }
        if(setGestureCount == 9){
            prevImage = ((UIImageView *)[view viewWithTag:9]);
        }
        if(setGestureCount == 10){
            prevImage = ((UIImageView *)[view viewWithTag:10]);
        }
        if(setGestureCount == 11){
            prevImage = ((UIImageView *)[view viewWithTag:11]);
        }
        if(setGestureCount == 12){
            prevImage = ((UIImageView *)[view viewWithTag:12]);
        }
        if(setGestureCount == 13){
            prevImage = ((UIImageView *)[view viewWithTag:13]);
        }
        if(setGestureCount == 14){
            prevImage = ((UIImageView *)[view viewWithTag:14]);
        }
        if(setGestureCount == 15){
            prevImage = ((UIImageView *)[view viewWithTag:15]);
        }
            CGRect view1Frame =tappedView.frame;
            CGRect view2Frame = prevImage.frame;
            [UIView animateWithDuration:0.2 animations:^{
                tappedView.frame = view2Frame;
                prevImage.frame = view1Frame;
            }];
            
        
    }
   
}






#pragma mark - helper methods
-(void)timeout{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
