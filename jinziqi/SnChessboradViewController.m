//
//  SnChessboradViewController.m
//  jinziqi
//
//  Created by snow on 27/3/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "SnChessboradViewController.h"

@implementation UIImageView (compare)
-(NSComparisonResult)compare:(UIImageView *)img{
    UIImageView *v = (UIImageView *)self;
    NSNumber *a = [NSNumber numberWithInteger:v.tag];
    NSNumber *b = [NSNumber numberWithInteger:img.tag];
    NSComparisonResult r = [a compare:b];
    return r;
}
@end
@interface SnChessboradViewController ()

@end

@implementation SnChessboradViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initChessBoard{
    self = [super init];
    if (self) {
        _jinziqiCore = [[SnjinziqiCore alloc]init];
        _chessBoard = [[NSMutableArray alloc] init];
        for (id tag in [_jinziqiCore.chessboard allKeys]) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [img setBackgroundColor:[UIColor redColor]];
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UserClicked:)];
            [img addGestureRecognizer:singleTap];
            img.tag = [tag integerValue];
            [_chessBoard addObject:img];
        }

    }
    return self;
}
-(void) UserClicked:(UIGestureRecognizer *)gestureRecognizer{
    UIImageView *o = gestureRecognizer.view;
    NSInteger t = o.tag;
    NSLog(@"tapping tag is %d", t);
    switch (_jinziqiCore.who) {
        case player_a:
            if ([_jinziqiCore.player_A addStep:t]) {
                [_jinziqiCore whoPlaying:player_b];
                o.image = [UIImage imageNamed:_jinziqiCore.player_A.chessImage];
                if ([_jinziqiCore isWin:_jinziqiCore.player_A.chessStep]) {
                    NSLog(@"player a win");
                }
            }
            break;
        case player_b:
            if ([_jinziqiCore.player_B addStep:t]) {
                [_jinziqiCore whoPlaying:player_a];
                o.image = [UIImage imageNamed:_jinziqiCore.player_B.chessImage];
                if ([_jinziqiCore isWin:_jinziqiCore.player_B.chessStep]) {
                    NSLog(@"player b win");
                }
            }
            break;
        default:
            break;
    }
    NSLog(@"和了！");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //draw chessboard
    int y = 100;
    int flag = 1;
    
    NSArray *sortedChessBoard = [_chessBoard sortedArrayUsingSelector:@selector(compare:)];
    for (NSInteger i = 0; i < [sortedChessBoard count]; i++) {
        UIImageView *v = sortedChessBoard[i];
        if (flag > 3) {
            flag = 1;
            y -=50;
        }
//        NSLog(@"flag = %d",flag);
//        NSLog(@"x = %d", (flag -1)*50);
//        NSLog(@"y = %d", y);
        [v setFrame:CGRectMake((flag -1)*50, y, 50, 50)];
        [self.view addSubview:v];
        flag++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
