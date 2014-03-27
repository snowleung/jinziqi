//
//  SnjinziqiCore.h
//  jinziqi
//
//  Created by snow on 26/3/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SnPlayer : NSObject
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSMutableArray *chessStep;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *chessImage;
-(id)initWithTag:(NSInteger)t andChessImage:(NSString *)p;
@end
@interface SnPoint : NSObject

@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
-(id)initWithX:(NSInteger)x Y:(NSInteger)y;
-(BOOL)equalPoint:(SnPoint *)p;
@end

@interface SnjinziqiCore : NSObject

@property (nonatomic,strong) SnPlayer *player_A;
@property (nonatomic,strong) SnPlayer *player_B;
@property (nonatomic,strong) NSDictionary *chessboard;
@property (nonatomic,strong) NSMutableArray *chesses;
-(SnPoint *) chessboardWithPosition:(NSInteger )pos;
-(BOOL) islineWithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c;
-(BOOL) addChess:(NSInteger) chess;
-(NSMutableArray *)chessesTotals;
-(NSArray *)playerChessesCombinationsWithSet:(NSArray *)arr andCombin:(NSInteger) c;
-(BOOL)isWin:(NSArray *)step;
@end

