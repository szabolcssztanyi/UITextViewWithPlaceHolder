//
//  ViewController.m
//  CommentTextViewTest
//
//  Created by Szabolcs Sztanyi on 01/04/15.
//  Copyright (c) 2015 Szabolcs Sztanyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)userTappedView:(UIGestureRecognizer*)tapGestureRecognizer
{
    [self.view endEditing:YES];
}

@end
