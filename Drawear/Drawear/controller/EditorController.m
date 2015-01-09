//
//  EditorController.m
//  Drawear
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "EditorController.h"
#import "UIImageViewEx.h"
#import "UITextFieldEx.h"
#import "CLImageEditor.h"
#import <QuartzCore/QuartzCore.h>
#import "DrawCompleteController.h"
#import "TouchDrawView.h"

@interface EditorController() <CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>{
    
}

//@property (strong, nonatomic) IBOutlet UIView *drawView;
@property (weak, nonatomic) IBOutlet UIView *drawView;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;

@end

@implementation EditorController

@synthesize picker = _picker;
@synthesize drawArea;

UIView *currTop;
UIImageViewEx *background;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: adjust draw board frame
    [self initDrawBoard];

    // add sample images
    [self addImageByPath:@"wukong.png"];
    [self addImageByPath:@"juhua.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)initDrawBoard {
    // init default background
    background = [[UIImageViewEx alloc] init];
    [background setCenter:self.drawView.center];
    [background setFrame:self.drawView.frame];
    [background setContentMode: UIViewContentModeScaleAspectFit];
    [background setController: self];
    [background enableTapAsBackground];
    
    drawArea = [[TouchDrawView alloc] initWithFrame:background.frame];
    [drawArea initButton];
    [drawArea setCenter:self.drawView.center];
    [drawArea setFrame:self.drawView.frame];
    [drawArea setContentMode: UIViewContentModeScaleAspectFit];
    
    [self setBackgroundByPath: @"T-shirt.png"];
    
    [self.undoButton setHidden:YES];
    
    [self.drawView addSubview:background];
    [self.drawView addSubview:drawArea];
    
}

- (IBAction)addPictureTapped:(id)sender {
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
//    [sheet showInView:self.view];
    if (self.picker == nil) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
    }
    [self presentViewController:_picker animated:YES completion:nil];
    [self switchDrawArea];
}

- (IBAction)addTextTapped:(id)sender {
    [self addTextByText:@"请输入文字"];
    [self switchDrawArea];
}

- (IBAction)addDrawTapped:(id)sender {
    [self.undoButton setHidden:drawArea.canDraw];
    [self.drawView bringSubviewToFront:self.undoButton];
    [self switchDrawArea];
}

- (IBAction)undoInController:(id)sender
{
    [drawArea undo];
}

- (void)switchDrawArea
{
    [drawArea switchVisible];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    if(fullImage){
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:fullImage delegate:self];
        
        [self presentViewController:editor animated:YES completion:nil];
        //[editor showInViewController:self withImageView:_imageView];
    }
//    [self addImageByImage:fullImage];
}

- (void)setCurrTop: (UIView*) view {
    if (view == nil) {
        currTop = nil;
    }
    if(currTop != nil){
        if ([currTop isKindOfClass:[UIImageViewEx class]]) {
            [(UIImageViewEx *)currTop setTop: NO];
        }
        if ([currTop isKindOfClass:[UITextFieldEx class]]) {
            [(UITextFieldEx *)currTop setTop: NO];
        }
        
    }
    currTop = view;
    [self.drawView bringSubviewToFront:currTop];
    if(currTop != nil){
        if ([currTop isKindOfClass:[UIImageViewEx class]]) {
            [(UIImageViewEx *)currTop setTop: YES];
        }
        if ([currTop isKindOfClass:[UITextFieldEx class]]) {
            [(UITextFieldEx *)currTop setTop: YES];
            [(UITextFieldEx *)currTop resignFirstResponder];
        }
        
    }
}

- (void)addImageByView: (UIImageViewEx *) view {
    [view setCenter: self.drawView.center];
    [view setController: self];
    [view enablePan];
    [view enableScaleAndRotation];
    [view enableDelete];
    
    [self.drawView addSubview:view];
}

- (void)addImageByImage: (UIImage *) image {
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    [self addImageByView:imageView];
}

- (void)addImageByPath: (NSString *) path {
    UIImage *image = [UIImage imageNamed:path];
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    [self addImageByView:imageView];
}

- (void)addTextByView: (UITextFieldEx *) textField {
    [textField setCenter:self.drawView.center];
    [textField setController: self];
    [textField enablePan];
    [textField enableScaleAndRotation];
    [textField enableDelete];
    
    [self.drawView addSubview:textField];
}

- (void)addTextByText: (NSString *) text {
    UITextFieldEx *textField = [[UITextFieldEx alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [textField initWithTextAttribute];
    textField.text = text;

    [self addTextByView:textField];
}

- (void)setBackgroundByImage: (UIImage *) image {
    [background setImage:image];
}

- (void)setBackgroundByPath: (NSString *) path {
    UIImage *image = [UIImage imageNamed:path];
    [background setImage:image];
}

- (void)tapBackground
{
    NSLog(@"tapBackground\n");
    if(currTop != nil){
        if ([currTop isKindOfClass:[UIImageViewEx class]]) {
            [(UIImageViewEx *)currTop setTop: NO];
        }
        if ([currTop isKindOfClass:[UITextFieldEx class]]) {
            [(UITextFieldEx *)currTop setTop: NO];
            [(UITextFieldEx *)currTop resignFirstResponder];
        }
        currTop = nil;
    }
}

-(void)aColorPickerIsSelected:(UIColor *)color{
    [drawArea setDrawColor:color];
}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    UIImage* newImage = image;
    [self addImageByImage:newImage];

    [editor dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- Actionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

@end
