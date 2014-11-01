//
//  ImageViewController.h
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController{
    int tapCounter;
    int setGestureCount;
    float timeCount;
    UIImageView *prevImage;
    UIImageView *prevImage1;
    UIImageView *newImage;
    UIImageView *tappedView;
    CGRect *frame2;
    UIView *view;
    
    
    
    
}


@property (nonatomic, strong)PFObject *message;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end
