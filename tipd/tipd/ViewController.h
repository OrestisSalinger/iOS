//
//  ViewController.h
//  tipd
//
//  Created by Orestis Salinger on 14.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *billAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentage;
@property (weak, nonatomic) IBOutlet UITextField *tipAmount;
@property (weak, nonatomic) IBOutlet UITextField *totalAmount;
- (IBAction)tipPercentageChanged:(UISegmentedControl *)sender;
- (void) displayTotalAmount:(float)amount;
- (void) displayTipAmount:(float)amount;
- (float) calculatePercantageForSegment:(int)segment;
- (float) getBillAmount;
- (float) calculateTipAmount:(float) amount percent:(float) percent;
- (void) updateDisplayedTip;
- (void) updateDisplayedTotal;


@end
