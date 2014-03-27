//
//  jinziqiTests.m
//  jinziqiTests
//
//  Created by snow on 26/3/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SnjinziqiCore.h"


@interface jinziqiTests : XCTestCase

@end

@implementation jinziqiTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testPlayer
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    XCTAssertEqualObjects([[NSMutableArray alloc]init], jinziqi.player_A, @"not NSMutableArray");
    XCTAssertEqualObjects([[NSMutableArray alloc]init], jinziqi.player_B, @"not NSMutableArray");
}
-(void)testChessboard
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    SnPoint *x1 = [[SnPoint alloc]initWithX:0 Y:0];
    SnPoint *x2 = [[SnPoint alloc]initWithX:0 Y:1];
    SnPoint *x3 = [[SnPoint alloc]initWithX:0 Y:2];
    SnPoint *x4 = [[SnPoint alloc]initWithX:1 Y:0];
    SnPoint *x5 = [[SnPoint alloc]initWithX:1 Y:1];
    SnPoint *x6 = [[SnPoint alloc]initWithX:1 Y:2];
    SnPoint *x7 = [[SnPoint alloc]initWithX:2 Y:0];
    SnPoint *x8 = [[SnPoint alloc]initWithX:2 Y:1];
    SnPoint *x9 = [[SnPoint alloc]initWithX:2 Y:2];
    XCTAssertTrue([x1 equalPoint:[jinziqi chessboardWithPosition:1]]);
    XCTAssertTrue([x2 equalPoint:[jinziqi chessboardWithPosition:2]]);
    XCTAssertTrue([x3 equalPoint:[jinziqi chessboardWithPosition:3]]);
    XCTAssertTrue([x4 equalPoint:[jinziqi chessboardWithPosition:4]]);
    XCTAssertTrue([x5 equalPoint:[jinziqi chessboardWithPosition:5]]);
    XCTAssertTrue([x6 equalPoint:[jinziqi chessboardWithPosition:6]]);
    XCTAssertTrue([x7 equalPoint:[jinziqi chessboardWithPosition:7]]);
    XCTAssertTrue([x8 equalPoint:[jinziqi chessboardWithPosition:8]]);
    XCTAssertTrue([x9 equalPoint:[jinziqi chessboardWithPosition:9]]);
}
-(void)testLineX
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    SnPoint *a = [jinziqi chessboardWithPosition:1];
    SnPoint *b = [jinziqi chessboardWithPosition:2];
    SnPoint *c = [jinziqi chessboardWithPosition:3];
    XCTAssertTrue([jinziqi islineWithPointA:a PointB:b andPointC:c], @"need True");
    a = [jinziqi chessboardWithPosition:1];
    b = [jinziqi chessboardWithPosition:8];
    c = [jinziqi chessboardWithPosition:3];
    XCTAssertFalse([jinziqi islineWithPointA:a PointB:b andPointC:c], @"need False");
}
-(void)testLineY
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    SnPoint *a = [jinziqi chessboardWithPosition:1];
    SnPoint *b = [jinziqi chessboardWithPosition:4];
    SnPoint *c = [jinziqi chessboardWithPosition:7];
    XCTAssertTrue([jinziqi islineWithPointA:a PointB:b andPointC:c], @"need True");
    a = [jinziqi chessboardWithPosition:1];
    b = [jinziqi chessboardWithPosition:8];
    c = [jinziqi chessboardWithPosition:3];
    XCTAssertFalse([jinziqi islineWithPointA:a PointB:b andPointC:c], @"need False");

}

-(void)testLineXY
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    SnPoint *a = [jinziqi chessboardWithPosition:1];
    SnPoint *b = [jinziqi chessboardWithPosition:5];
    SnPoint *c = [jinziqi chessboardWithPosition:9];
    XCTAssertTrue([jinziqi islineWithPointA:a PointB:b andPointC:c], @"need True");
    a = [jinziqi chessboardWithPosition:7];
    b = [jinziqi chessboardWithPosition:5];
    c = [jinziqi chessboardWithPosition:3];
    XCTAssertTrue([jinziqi islineWithPointA:a PointB:b andPointC:c], @"need True");
}

-(void)testChessUseful
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    XCTAssertTrue([jinziqi addChess:1], @"");
    XCTAssertTrue([jinziqi addChess:2], @"");
    XCTAssertFalse([jinziqi addChess:1], @"has the same chess");
}
-(void)testChessTotal
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    [jinziqi addChess:8];
    [jinziqi addChess:9];
    NSMutableArray *totals = [jinziqi chessesTotals];
    NSMutableArray *test_totals = [@[@1, @2, @3, @4, @5, @6, @7] mutableCopy];
    XCTAssertTrue([test_totals isEqualToArray:totals], @"");
    [test_totals addObject:@8];
    XCTAssertFalse([test_totals isEqualToArray:totals], @"");
}
-(void)testChessCombinations
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    NSArray *r = [jinziqi playerChessesCombinationsWithSet:@[@"a", @"b", @"c", @"d"] andCombin:3];
    NSArray *result = @[@[@"a", @"b", @"c"], @[@"a", @"b", @"d"], @[@"a", @"c", @"d"], @[@"b", @"c", @"d"]];
    XCTAssertTrue([result isEqualToArray:r], @"");
    result = @[@[@"a", @"b", @"c"], @[@"a", @"b", @"d"], @[@"a", @"c", @"d"], @[@"b", @"c", @"c"]];
    XCTAssertFalse([result isEqualToArray:r], @"");
    
    r = [jinziqi playerChessesCombinationsWithSet:@[@1, @2, @3, @4] andCombin:3];
    result = @[@[@1, @2, @3], @[@1, @2, @4], @[@1, @3, @4], @[@2, @3, @4]];
    XCTAssertTrue([result isEqualToArray:r], @"");
    result = @[@[@1, @2, @3], @[@1, @2, @4], @[@1, @3, @4], @[@2, @3, @2]];
    XCTAssertFalse([result isEqualToArray:r], @"");
}
-(void)testIsWin
{
    SnjinziqiCore *jinziqi = [[SnjinziqiCore alloc]init];
    NSArray *a = @[@1, @2, @3, @7, @8];
    XCTAssertTrue([jinziqi isWin:a], @"");
    NSArray *b = @[@7, @8, @9, @5];
    XCTAssertTrue([jinziqi isWin:b], @"");
    NSArray *c = @[@1, @2, @7, @8];
    XCTAssertFalse([jinziqi isWin:c], @"");
}
@end
