//
//  SnjinziqiCore.m
//  jinziqi
//
//  Created by snow on 26/3/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "SnjinziqiCore.h"

@implementation SnPoint
-(id)init{
    if (self = [super init]) {
        //
    }
    return self;
}
-(id)initWithX:(NSInteger)x Y:(NSInteger)y{
    if (self = [super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}
-(BOOL)equalPoint:(SnPoint *)p{
    return self.x == p.x && self.y == p.y;
}

@end
@implementation SnjinziqiCore

-(id)init{
    if (self = [super init]) {
        self.player_A = [[NSMutableArray alloc]init];
        self.player_B = [[NSMutableArray alloc]init];
        //init chessboard
        _chessboard = @{
                        @1: [[SnPoint alloc]initWithX:0 Y:0],
                        @2: [[SnPoint alloc]initWithX:0 Y:1],
                        @3: [[SnPoint alloc]initWithX:0 Y:2],
                        @4: [[SnPoint alloc]initWithX:1 Y:0],
                        @5: [[SnPoint alloc]initWithX:1 Y:1],
                        @6: [[SnPoint alloc]initWithX:1 Y:2],
                        @7: [[SnPoint alloc]initWithX:2 Y:0],
                        @8: [[SnPoint alloc]initWithX:2 Y:1],
                        @9: [[SnPoint alloc]initWithX:2 Y:2],
                        };
        _chesses = [[NSMutableArray alloc] init];
    }
    return self;
}
-(BOOL)isWin:(NSArray *)step
{
    NSArray *combinations = [self playerChessesCombinationsWithSet:step andCombin:3];
    for (NSArray *array in combinations) {
        SnPoint *a = _chessboard[array[0]];
        SnPoint *b = _chessboard[array[1]];
        SnPoint *c = _chessboard[array[2]];
        if ([self islineWithPointA:a PointB:b andPointC:c]) {
            return YES;
        }
    }
    return NO;
}
-(BOOL) addChess:(NSInteger)chess
{
    if (chess<1 || chess>9) return NO;
    if (![_chesses containsObject:[NSNumber numberWithInteger:chess]]) {
        [_chesses addObject:[NSNumber numberWithInteger:chess]];
        return YES;
    }else{
        return NO;
    }
}
-(NSArray *)playerChessesCombinationsWithSet:(NSArray *)arr andCombin:(NSInteger) c
{
    if (c != 3) {
        //just support 3
        return @[];
    }
    NSMutableArray *combinations = [[NSMutableArray alloc]init];
    NSInteger len = [arr count];
    for (int i = 0; i < len; i++) {
        for (int j = i + 1; j < len; j++) {
            for (int k = j + 1; k < len; k++) {
                NSArray *r = @[arr[i], arr[j], arr[k]];
                [combinations addObject:r];
            }
        }
    }
    return combinations;
}
-(NSMutableArray *)chessesTotals{
    NSMutableSet *a = [NSMutableSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    NSSet *b = [NSSet setWithArray:_chesses];
    [a minusSet:b];
    NSArray *new_a = [a sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]]];
    return [new_a mutableCopy];
}
-(SnPoint *) chessboardWithPosition:(NSInteger)pos
{
    return [self.chessboard objectForKey:[NSNumber numberWithInteger:pos]];
}
-(BOOL) isline_x_WithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c
{
    return a.x == b.x && b.x == c.x;
}
-(BOOL) isline_y_WithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c
{
    return a.y == b.y && b.y == c.y;
}
-(BOOL) isline_xy_1_WithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c
{
    //f(x) = x
    BOOL result = YES;
    NSArray *iter_array = @[a,b,c];
    for (SnPoint* p in iter_array) {
        if (p.x == p.y) result = YES;
        else {result = NO; break;}
    }
    return result;
}
-(BOOL) isline_xy_2_WithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c
{
    //f(x) = 2 - x
    BOOL result = YES;
    NSArray *iter_array = @[a,b,c];
    for (SnPoint* p in iter_array) {
        if (p.y == (2 - p.x)) result = YES;
        else{result = NO; break;}
    }
    return result;
}
-(BOOL) islineWithPointA:(SnPoint *)a PointB:(SnPoint *)b andPointC:(SnPoint *)c
{
    if ([self isline_x_WithPointA:a PointB:b andPointC:c]) return YES;
    if ([self isline_y_WithPointA:a PointB:b andPointC:c]) return YES;
    if ([self isline_xy_1_WithPointA:a PointB:b andPointC:c]) return YES;
    if ([self isline_xy_2_WithPointA:a PointB:b andPointC:c]) return YES;
    return NO;
}

@end
