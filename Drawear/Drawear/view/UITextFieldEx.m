//
//  UIImageViewEx.m
//  GestureTutorial
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import "UITextFieldEx.h"
#import "EditorController.h"

@implementation UITextFieldEx
@synthesize controller, closeButton;
@synthesize isRotateEnable,isPanEnable,isPinchEnable,isTap,isTop;
@synthesize imageSize,imageRotation,imagePoint;

- (void)initWithTextAttribute
{
    self.textColor = [UIColor blackColor];
    self.font = [UIFont fontWithName:@"Arial" size:16.0];
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.returnKeyType = UIReturnKeyDone;
    self.keyboardType =UIKeyboardTypeDefault;
    self.delegate = self;
    self.adjustsFontSizeToFitWidth = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

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
- (IBAction)removeSelf:(id)sender {
    [self removeFromSuperview];
}

- (void) textFieldDidChange:(id) sender {
    UITextField *_field = (UITextField *)sender;
    NSString *text = _field.text;
    CGRect rect = _field.frame;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:_field.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, rect.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    [_field setFrame:CGRectMake(rect.origin.x, rect.origin.y, size.size.width + 30, rect.size.height)];
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
    self.userInteractionEnabled=YES;
    
    isTap = NO;
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapRecognize.numberOfTapsRequired = 1;
    tapRecognize.delegate = self;
    [tapRecognize setEnabled :YES];
    [tapRecognize delaysTouchesBegan];
    [tapRecognize cancelsTouchesInView];
    
    [self addGestureRecognizer:tapRecognize];
    
    isTop = NO;
    closeButton = [[UIButton alloc] initWithFrame:CGRectMake(-5, -5, 15, 15)];
    [closeButton setBackgroundImage: [UIImage imageNamed:@"close.png"]
                           forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setHidden:YES];
   
    [self setRightView:closeButton];
    [self setRightViewMode:UITextFieldViewModeAlways];
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

- (void)enableTapAsBackground {
    UIView *parentView=controller.view;
    parentView.userInteractionEnabled=YES;
    self.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *backgroundRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAsBackground:)];
    backgroundRecognize.numberOfTapsRequired = 1;
    backgroundRecognize.delegate = self;
    [backgroundRecognize setEnabled :YES];
    [backgroundRecognize delaysTouchesBegan];
    [backgroundRecognize cancelsTouchesInView];
    
    [self addGestureRecognizer:backgroundRecognize];
}

/*
 * setInfoText
 * @string NSString
 */
- (void)setInfoText:(NSString *)string
{
   
}
/*
 *  SetShadow
 *  @isShadow
 */
- (void)setTop:(BOOL)isCurrTop
{
    isTop = isCurrTop;
    if (!isCurrTop) {
        if ([self.text length]==0) {
            [self removeFromSuperview];
        }
        [closeButton setHidden:YES];
    }else{
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
    if (recognizer.state == UIGestureRecognizerStateBegan) {
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
    if (recognizer.state == UIGestureRecognizerStateBegan) {
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
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [controller setCurrTop:self];
    }
}

/*
 *  handleTap
 *  @recognizer  UITapGestureRecognizer
 */
- (void) handleTap:(UITapGestureRecognizer *)recognizer
{
    [controller setCurrTop:self];
    [self becomeFirstResponder];
}

- (void) handleTapAsBackground:(UITapGestureRecognizer *)recognizer
{
    [controller tapBackground];
}

/*
 *  gestureRecognizer
 *  @return
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
