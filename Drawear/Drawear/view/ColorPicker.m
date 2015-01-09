//
//  ColorPicker.m
//  DrawTutorial
//
//  Created by Sidney on 1/9/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([delegate respondsToSelector:@selector(aColorPickerIsSelected:)]) {
        [delegate aColorPickerIsSelected:[self backgroundColor]];
    }
    self.layer.borderWidth = 1.5f;
    self.layer.borderColor = [[UIColor redColor]CGColor];
}
@end
