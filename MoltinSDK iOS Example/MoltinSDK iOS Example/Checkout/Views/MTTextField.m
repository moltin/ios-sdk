//
//  MTTextField.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 24/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTTextField.h"

@implementation MTTextField

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont fontWithName:kMoltinFontBold size:15];
        self.backgroundColor = RGB(58, 73, 84);
        [self setValue:RGB(99, 117, 130) forKeyPath:@"_placeholderLabel.textColor"];
        
        self.tintColor = [UIColor whiteColor];
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.layer.cornerRadius = 5;
        
        [self addTarget:self
                 action:@selector(textFieldDidChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    if (self.hideCursor) {
        return CGRectZero;
    } else {
        return [super caretRectForPosition:position];
    }
}

- (void)clearBorder{
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setInvalidInputBorder{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 2;
}

- (BOOL)isEmpty{
    return (self.text.length == 0 || [self.text isEqualToString:@""]);
}

- (void)setDoneInputAccessoryView{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnDoneTap:)];
    [toolbar setItems:@[space, barButtonItem]];
    [self setInputAccessoryView:toolbar];
}

- (void)btnDoneTap:(id)sender
{
    [self resignFirstResponder];
}

- (void)textFieldDidChange:(MTTextField *) sender{
    [sender clearBorder];
}

@end
