//
//  ViewController.m
//  tipd
///Users/orestis/Documents/workspace/iOS/tipd/tipd/ViewController.m
//  Created by Orestis Salinger on 14.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self showKeyboard];
}


- (void)showKeyboard
{
    [self.billAmount becomeFirstResponder];
}

- (void) dismissKeyboard
{
    [self.billAmount resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{   
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) formatCurrency:(float)amount
{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterCurrencyStyle;
    NSNumber *number = [NSNumber numberWithFloat:amount];
    return [nf stringFromNumber:number];
}

- (void) displayTotalAmount:(float)amount
{
    self.totalAmount.text = [self formatCurrency:amount];
};

- (void) displayTipAmount:(float)amount
{
    self.tipAmount.text = [self formatCurrency:amount];
};

- (float) calculatePercantageForSegment:(int)segment
{
    NSString *tipText = [self.tipPercentage titleForSegmentAtIndex:segment];
    return [tipText floatValue] / 100.00;
};

- (IBAction)tipPercentageChanged:(UISegmentedControl *)sender {
    [self updateDisplayedTip];
    [self updateDisplayedTotal];
    [self dismissKeyboard];
};

- (float) getBillAmount
{
    return [self.billAmount.text floatValue];
};

- (float) calculateTipAmount:(float) amount percent:(float) percent
{
    return amount * percent;
}

- (void) updateDisplayedTip
{
    float amount = [self getBillAmount];
    int segment = self.tipPercentage.selectedSegmentIndex;
    float percent = [self calculatePercantageForSegment:segment];
    float tip = [self calculateTipAmount:amount percent:percent];
    self.tipAmount.text = [self formatCurrency:tip];
}

- (void) updateDisplayedTotal
{
    float amount = [self getBillAmount];
    int segment = self.tipPercentage.selectedSegmentIndex;
    float percent = [self calculatePercantageForSegment:segment];
    float tip = [self calculateTipAmount:amount percent:percent];
    self.totalAmount.text = [self formatCurrency:tip + amount];
}

@end
