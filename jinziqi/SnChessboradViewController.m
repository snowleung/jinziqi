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
        _infoBoard = [[UIAlertView alloc]initWithFrame:CGRectMake(0, 0, 100, 300)];
        _infoBoard.delegate = self;
        [_infoBoard addButtonWithTitle:@"i know"];
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
    UIImageView *o =(UIImageView *) gestureRecognizer.view;
    NSInteger t = o.tag;
//    NSLog(@"tapping tag is %d", t);
    if (![_jinziqiCore addChess:t]) {
        //press the same chess should be return at twice;
        return;
    }
    switch (_jinziqiCore.who) {
        case player_a:
            if ([_jinziqiCore.player_A addStep:t]) {
                [_jinziqiCore whoPlaying:player_b];
                o.image = [UIImage imageNamed:_jinziqiCore.player_A.chessImage];
                if ([_jinziqiCore isWin:_jinziqiCore.player_A.chessStep]) {
                    [self showInfoBoard:@"player a win"];
                }
            }
            break;
        case player_b:
            if ([_jinziqiCore.player_B addStep:t]) {
                [_jinziqiCore whoPlaying:player_a];
                o.image = [UIImage imageNamed:_jinziqiCore.player_B.chessImage];
                if ([_jinziqiCore isWin:_jinziqiCore.player_B.chessStep]) {
                    [self showInfoBoard:@"player b win"];
                }
            }
            break;
        default:
            break;
    }
    if ((_jinziqiCore.player_A.chessStep.count + _jinziqiCore.player_B.chessStep.count) == 9) {
        [self showInfoBoard:@"nobody win , play again"];
    }
}
- (void)showInfoBoard:(NSString *)msg
{
    _infoBoard.message = msg;
    [_infoBoard show];
}
- (void)cleanChessboard
{
    for (UIImageView *i in _chessBoard) {
        i.image = nil;
    }
}
- (void)cleanCore
{
    _jinziqiCore = nil;
    _jinziqiCore = [[SnjinziqiCore alloc]init];
    [self cleanChessboard];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //draw chessboard
    int y = 250;
    int flag = 1;
    int border = 1;
    int coord_offset = 80;
    NSArray *sortedChessBoard = [_chessBoard sortedArrayUsingSelector:@selector(compare:)];
    for (NSInteger i = 0; i < [sortedChessBoard count]; i++) {
        UIImageView *v = sortedChessBoard[i];
        if (flag > 3) {
            flag = 1;
            y = y - (50 + border);
        }
//        NSLog(@"flag = %d",flag);
//        NSLog(@"x = %d", (flag -1)*50);
//        NSLog(@"y = %d", y);
        [v setFrame:CGRectMake((flag - 1)*(50 + border) + coord_offset, y , 50, 50)];
        [self.view addSubview:v];
        flag++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---uialterview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"press the alert button");
    [self cleanCore];
}

@end
