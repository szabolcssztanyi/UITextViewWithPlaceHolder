//
//  CommentTextView.m
//  CommentTextViewTest
//
//  Created by Szabolcs Sztanyi on 01/04/15.
//  Copyright (c) 2015 Szabolcs Sztanyi. All rights reserved.
//

#import "CommentTextView.h"

@interface CommentTextView ()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation CommentTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addPlaceHolderLabel];
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addPlaceHolderLabel];
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.tintColor = [UIColor lightGrayColor];
    self.textColor = [UIColor blackColor];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (self.text.length > 0) {
        self.placeHolderLabel.alpha = 0.0;
    } else {
        self.placeHolderLabel.alpha = 1.0;
    }
}

- (void)addPlaceHolderLabel
{
    self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, CGRectGetWidth(self.frame)-20.0, 20.0)];
    self.placeHolderLabel.text = @"Add comment here";
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    self.placeHolderLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.placeHolderLabel];
    
    // setup constraints
    // left constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeHolderLabel
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0 constant:10.0]];
    // right constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeHolderLabel
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self attribute:NSLayoutAttributeRight
                                                    multiplier:1.0 constant:10.0]];
    // top constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeHolderLabel
                                                     attribute:NSLayoutAttributeTopMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self attribute:NSLayoutAttributeTopMargin
                                                    multiplier:1.0 constant:5.0]];
    // height constraint
    [self.placeHolderLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.placeHolderLabel
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0 constant:20.0]];
}

- (BOOL)isPlaceHolderLabelVisible
{
    return self.placeHolderLabel.alpha == 1;
}

- (void)setPlaceHolderLabelVisible:(BOOL)visible
{
    // if the placeholder needs to be displayed, but it is already visible
    // OR the label is hidden, and needs to be hidden, just ignore this method
    if ((visible == [self isPlaceHolderLabelVisible]) || self.text.length > 0) {
        return;
    }

    // animate the label upwards
    [self animatePlaceHolderLabelUpwards:visible];

    // animate the alpha value of the label
//    [UIView animateWithDuration:0.3 animations:^{
//        self.placeHolderLabel.alpha = visible ? 1.0 : 0.0;
//    }];
}

- (BOOL)becomeFirstResponder
{
    [self setPlaceHolderLabelVisible:NO];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setPlaceHolderLabelVisible:YES];
    return [super resignFirstResponder];
}

#pragma mark - animation methods
- (void)animatePlaceHolderLabelUpwards:(BOOL)visible
{
    [UIView animateWithDuration:0.3 animations:^{
        if (visible) {
            self.placeHolderLabel.alpha = 1.0;
            self.placeHolderLabel.transform = CGAffineTransformIdentity;
        } else {
            self.placeHolderLabel.alpha = 0.0;
            self.placeHolderLabel.transform = CGAffineTransformMakeTranslation(0.0, -10.0);
        }
    }];
}

@end