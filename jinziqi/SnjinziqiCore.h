//
//  SnjinziqiCore.h
//  jinziqi
//
//  Created by snow on 26/3/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SnPoint : NSObject

@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;
-(id)initWithX:(NSInteger)x Y:(NSInteger)y;
-(BOOL)equalPoint:(SnPoint *)p;
@end

@interface SnjinziqiCore : NSObject

@property (nonatomic,strong) NSMutableArray *player_A;
@property (nonatomic,strong) NSMutableArray *player_B;
@property (nonatomic,strong) NSDictionary *chessboard;
-(SnPoint *) chessboardWithPosition:(NSInteger )pos;
-(BOOL) islineWithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c;
@end

