//
//  tipdTests.m
//  tipdTests
//
//  Created by Orestis Salinger on 14.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface tipdTests : XCTestCase

@property (strong,nonatomic) ViewController *vc;

@end

@implementation tipdTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.vc = [storyboard instantiateInitialViewController];
    
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testVcInstatiates
{
    XCTAssertNotNil(self.vc);
}

- (void)testDisplayTotalAmountForZero
{
    [self.vc displayTotalAmount:0];
    NSString *result = self.vc.totalAmount.text;
    XCTAssertEqualObjects(result, @"$0.00");
}


- (void)testDisplayTotalAmountForOne
{
    [self.vc displayTotalAmount:1];
    NSString *result = self.vc.totalAmount.text;
    XCTAssertEqualObjects(result, @"$1.00");
}

- (void)testDisplayTotalAmountFor10
{
    [self.vc displayTotalAmount:10];
    NSString *result = self.vc.totalAmount.text;
    XCTAssertEqualObjects(result, @"$10.00");
}

- (void)testDisplayTipAmountForZero{
    [self.vc displayTipAmount:0];
    NSString *result = self.vc.tipAmount.text;
    XCTAssertEqualObjects(result, @"$0.00");
}

- (void)testDisplayTipAmountForOne
{
    [self.vc displayTipAmount:1];
    NSString *result = self.vc.tipAmount.text;
    XCTAssertEqualObjects(result, @"$1.00");
}

- (void)testDisplayTipAmountFor10
{
    [self.vc displayTipAmount:10];
    NSString *result = self.vc.tipAmount.text;
    XCTAssertEqualObjects(result, @"$10.00");
}

- (void)testGetBillAmountWhenBlank
{
    self.vc.billAmount.text = @"";
    float result = [self.vc getBillAmount];
    XCTAssertEqualWithAccuracy(result, 0.0, 0.001);
}

- (void)testGetBillAmountForOnePointOne
{
    self.vc.billAmount.text = @"1.1";
    float result = [self.vc getBillAmount];
    XCTAssertEqualWithAccuracy(result, 1.1, 0.001);
}

- (void)testGetBillAmountForOnePointOnePointOne
{
    self.vc.billAmount.text = @"1.1.1";
    float result = [self.vc getBillAmount];
    XCTAssertEqualWithAccuracy(result, 1.1, 0.001);
}



////////////////////////////////////


- (void)testCalcTipPercentageForSegmentZero
{
    float percent = [self.vc calculatePercantageForSegment:0];
    XCTAssertEqualWithAccuracy(percent, 0.05, 0.001,@"Expected percent %f should be 0.05", percent);
}

- (void)testCalcTipPercentageForSegmentOne
{
    float percent = [self.vc calculatePercantageForSegment:1];
    XCTAssertEqualWithAccuracy(percent, 0.10, 0.001,@"Expected percent %f should be 0.10", percent);
}

- (void)testCalcTipPercentageForSegmentTwo
{
    float percent = [self.vc calculatePercantageForSegment:2];
    XCTAssertEqualWithAccuracy(percent, 0.15, 0.001,@"Expected percent %f should be 0.12", percent);
}

- (void)testCalcTipPercentageForSegmentThree
{
    float percent = [self.vc calculatePercantageForSegment:3];
    XCTAssertEqualWithAccuracy(percent, 0.20, 0.001,@"Expected percent %f should be 0.20", percent);
}

- (void)testCalcTipPercentageForSegmentFour
{
    float percent = [self.vc calculatePercantageForSegment:4];
    XCTAssertEqualWithAccuracy(percent, 0.25, 0.001,@"Expected percent %f should be 0.25", percent);
}

- (void)testCalcTipAmount
{
    float tip = [self.vc calculateTipAmount:1.1 percent:0.10];
    XCTAssertEqualWithAccuracy(tip, 0.1, 0.05);
}

- (void) testUpdateDisplayTipForZero
{
    self.vc.billAmount.text = @"0";
    self.vc.tipPercentage.selectedSegmentIndex = 1;
    [self.vc updateDisplayedTip];
    NSString *tipString = self.vc.tipAmount.text;
    XCTAssertEqualObjects(tipString, @"$0.00");
}

- (void)testUpdateDisplayTipFor10By10
{
    self.vc.billAmount.text = @"10";
    self.vc.tipPercentage.selectedSegmentIndex = 1;
    [self.vc updateDisplayedTip];
    NSString *tipString = self.vc.tipAmount.text;
    XCTAssertEqualObjects(tipString, @"$1.00");
}

- (void)testUpdateDisplayTipFor10By15
{
    self.vc.billAmount.text = @"10";
    self.vc.tipPercentage.selectedSegmentIndex = 2;
    [self.vc updateDisplayedTip];
    NSString *tipString = self.vc.tipAmount.text;
    XCTAssertEqualObjects(tipString, @"$1.50");
}


- (void)testUpdateDisplayTotalForZero
{
    self.vc.billAmount.text = @"0";
    self.vc.tipPercentage.selectedSegmentIndex = 1;
    [self.vc updateDisplayedTotal];
    NSString *totalString = self.vc.totalAmount.text;
    XCTAssertEqualObjects(totalString, @"$0.00");
}

- (void)testUpdateDisplayTotalFor10By10
{
    self.vc.billAmount.text = @"10";
    self.vc.tipPercentage.selectedSegmentIndex = 1;
    [self.vc updateDisplayedTotal];
    NSString *tipString = self.vc.totalAmount.text;
    XCTAssertEqualObjects(tipString, @"$11.00");
}

















@end
