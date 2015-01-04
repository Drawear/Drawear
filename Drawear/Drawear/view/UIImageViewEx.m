//
//  UIImageViewEx.m
//  GestureTutorial
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import "UIImageViewEx.h"
#import "EditorController.h"

@implementation UIImageViewEx
@synthesize controller, closeButton;
@synthesize isRotateEnable,isPanEnable,isPinchEnable,isTap,isTop;
@synthesize imageSize,imageRotation,imagePoint;

/*
 * setController
 * @controller UIViewController;
 */
- (void)setController:(EditorController *) uiViewController
{
    controller = uiViewController;
}

/*
 * removeSelf
 * @sender id;
 */
- (IBAction)removeSelf:(id)sender{
    [self removeFromSuperview];
}

/*
 * enableScaleAndRotation
 */
- (void)enablePan
{
    UIView *parentView=controller.view;
    parentView.userInteractionEnabled=YES;
     self.userInteractionEnabled=YES;
    isPanEnable=YES;
    
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRcognize.delegate=self;
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    
    [self addGestureRecognizer:panRcognize];
}

/*
 * enableScaleAndRotation
 */
- (void)enableScaleAndRotation
{
    UIView *parentView=controller.view;
    parentView.userInteractionEnabled=YES;
    
    isPinchEnable=YES;
    isRotateEnable=YES;

    imageSize=1;
    imageRotation=0;
    
    imageScale= parentView.frame.size.width/self.frame.size.width;
    imagePoint= self.frame.origin;
    self.userInteractionEnabled=YES;
    
    UIPinchGestureRecognizer *pinchRcognize=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchRcognize setEnabled:YES];
    [pinchRcognize delaysTouchesEnded];
    [pinchRcognize cancelsTouchesInView];
    
    UIRotationGestureRecognizer *rotationRecognize=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [rotationRecognize setEnabled:YES];
    [rotationRecognize delaysTouchesEnded];
    [rotationRecognize cancelsTouchesInView];
    rotationRecognize.delegate=self;
    pinchRcognize.delegate=self;
    
    [self addGestureRecognizer:rotationRecognize];
    [self addGestureRecognizer:pinchRcognize];
    
}

/*
 * enableDelete
 */
- (void)enableDelete
{
    UIView *parentView=controller.view;
    parentView.userInteractionEnabled=YES;
    
    isTap = NO;
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapRecognize.numberOfTapsRequired = 1;
    tapRecognize.delegate = self;
    [tapRecognize setEnabled :YES];
    [tapRecognize delaysTouchesBegan];
    [tapRecognize cancelsTouchesInView];
    
    [self addGestureRecognizer:tapRecognize];
    
    isTop = NO;
    closeButton = [[UIButton alloc] initWithFrame:CGRectMake(-10, -10, 20, 20)];
    [closeButton setBackgroundImage: [UIImage imageNamed:@"/Users/apple/Documents/workspace/Drawear/Drawear/Drawear/Images.xcassets/image/close.imageset/close.png"]
                           forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setHidden:YES];
    [self addSubview:closeButton];
}

/*
 * setInfoText
 * @string NSString
 */
- (void)setInfoText:(NSString *)string
{
    if (textView!=nil) {
        [textView removeFromSuperview];
        textView = nil;
    }
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 0, 30)];
    textView.text = string;
    textView.hidden = YES;
    textView.textColor =[UIColor whiteColor];
    [self addSubview:textView];
}
/*
 *  SetShadow
 *  @isShadow
 */
- (void)setTop:(BOOL)isCurrTop
{
    isTop = isCurrTop;
    if (!isCurrTop) {
        [[self layer] setShadowOffset:CGSizeMake(0, 0)];
        [[self layer] setShadowRadius:0];
        [[self layer] setShadowOpacity:1];
        [[self layer] setShadowColor:[UIColor whiteColor].CGColor];
        [closeButton setHidden:YES];
    }else{
        [[self layer] setShadowOffset:CGSizeMake(3, 3)];
        [[self layer] setShadowRadius:3];
        [[self layer] setShadowOpacity:0.5];
        [[self layer] setShadowColor:[UIColor blackColor].CGColor];
        [closeButton setHidden:NO];
    }
}

#pragma UIGestureRecognizer Handles
/*
 *  @recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (!isPanEnable) {
        return;
    }
    UIView *parentView=controller.view;
    CGPoint translation = [recognizer translationInView:parentView];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:parentView];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [controller setCurrTop:self];
    }
}
/*
 * handPinch
 * @recognizer UIPinchGestureRecognizer
 */
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    if (!isPinchEnable) {
        return;
    }
    imageSize*=recognizer.scale;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [controller setCurrTop:self];
    }
}

/*
 * handleRotate
 * recognizer UIRotationGestureRecognizer
 */
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer{
    if (!isRotateEnable) {
        return;
    }
    imageRotation+=recognizer.rotation;
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
    [closeButton setFrame:CGRectMake(-10, -10, 20, 20)];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [controller setCurrTop:self];
    }
}

/*
 *  handleTap
 *  @recognizer  UITapGestureRecognizer
 */
-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    [controller setCurrTop:self];
}

/*
 *  gestureRecognizer
 *  @retur
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
