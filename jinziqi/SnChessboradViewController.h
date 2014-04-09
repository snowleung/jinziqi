//
//  SnChessboradViewController.h
//  jinziqi
//
//  Created by snow on 27/3/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnjinziqiCore.h"

@interface SnChessboradViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) SnjinziqiCore *jinziqiCore;
@property (nonatomic, strong) NSMutableArray *chessBoard;
@property (nonatomic, strong) UIAlertView *infoBoard;
@property (nonatomic, strong) UIButton *btn_restart;

-(void)showInfoBoard:(NSString *)msg;
-(id) initChessBoard;
-(void) cleanCore;
@end

@interface UIImageView (compare)

-(NSComparisonResult)compare:(UIImageView *)img;

@end