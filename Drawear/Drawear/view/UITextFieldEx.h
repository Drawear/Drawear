//
//  UIImageViewEx.h
//  GestureTutorial
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import <UIKit/UiKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EditorController.h"
#import "UITextFieldEx.h"

@interface UITextFieldEx : UITextField<UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    EditorController *controller;
    UIButton *closeButton;
    
    BOOL isPanEnable;
    BOOL isPinchEnable;
    BOOL isRotateEnable;
    BOOL isTap;
    BOOL isTop;
    
    CGFloat imageScale;
    CGFloat imageSize;
    CGFloat imageRotation;
    CGPoint imagePoint;
}

@property (nonatomic,retain) EditorController *controller;
@property (nonatomic,retain) UIButton *closeButton;
@property (nonatomic) CGFloat imageSize;
@property (nonatomic) CGFloat imageRotation;
@property (nonatomic) CGPoint imagePoint;

@property BOOL isPanEnable;
@property BOOL isRotateEnable;
@property BOOL isPinchEnable;
@property BOOL isTap;
@property BOOL isTop;

- (void)initWithTextAttribute;

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer;
- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (void)handleTapAsBackground:(UITapGestureRecognizer *)recognizer;

- (void)enablePan;
- (void)enableScaleAndRotation;
- (void)enableDelete;
- (void)enableTapAsBackground;
- (void)setInfoText:(NSString *)string;
- (void)setTop:(BOOL)isCurrTop;

- (void)setController:(EditorController *) uiViewController;
- (IBAction)removeSelf:(id)sender;
- (void) textFieldDidChange:(id) sender;

@end