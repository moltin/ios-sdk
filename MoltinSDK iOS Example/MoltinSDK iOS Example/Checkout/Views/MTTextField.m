//
//  MTTextField.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 24/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
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
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 45)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.layer.cornerRadius = 5;
        
        [self addTarget:self
                 action:@selector(textFieldDidChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
    return self;
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

- (void)textFieldDidChange:(MTTextField *) sender{
    [sender clearBorder];
}

@end
