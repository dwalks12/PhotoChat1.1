//
//  BlockView.h
//  PhotoChat
//
//  Created by Dawson Walker on 2014-10-14.
//  Copyright (c) 2014 Dawson Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BlockView : UIView
@property (nonatomic) int blockId;
@property (nonatomic) BOOL displayId;
@property (nonatomic) CGPoint originalPosition;
@property (nonatomic) CGPoint currentPosition;
@property (nonatomic) CGPoint moveToPosition;
@property (nonatomic, retain) UIImageView *imageView;
- (id)initWithFrame:(CGRect)frame id:(int)anId showId:(BOOL)aFlag;
@end
