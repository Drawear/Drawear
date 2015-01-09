
//
//  TouchDrawView.m
//  DrawTutorial
//
//  Created by Sidney on 1/9/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import "TouchDrawView.h"

@implementation TouchDrawView
{
}

@synthesize currentLine;
@synthesize linesCompleted;
@synthesize drawColor;
@synthesize canDraw;

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        linesCompleted = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
        
        drawColor = [UIColor blackColor];
        [self becomeFirstResponder];
    }
    return self;
}

//  It is a method of UIView called every time the screen needs a redisplay or refresh.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    [drawColor set];
    for (Line *line in linesCompleted) {
        [[line color] set];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
}

- (void)undo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
        [self setNeedsDisplay];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (canDraw) {
        [self.undoManager beginUndoGrouping];
        for (UITouch *t in touches) {
            // Create a line for the value
            CGPoint loc = [t locationInView:self];
            Line *newLine = [[Line alloc] init];
            [newLine setBegin:loc];
            [newLine setEnd:loc];
            [newLine setColor:drawColor];
            currentLine = newLine;
        }
        
    }
}

- (void)addLine:(Line*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [linesCompleted addObject:line];
    [self setNeedsDisplay];
}

- (void)removeLine:(Line*)line
{
    if ([linesCompleted containsObject:line]){
        [linesCompleted removeObject:line];
    }
    [self setNeedsDisplay];
}

- (void)removeLineByEndPoint:(CGPoint)point
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Line *evaluatedLine = (Line*)evaluatedObject;
        return evaluatedLine.end.x == point.x &&
        evaluatedLine.end.y == point.y;
    }];
    NSArray *result = [linesCompleted filteredArrayUsingPredicate:predicate];
    if (result && result.count > 0) {
        [linesCompleted removeObject:result[0]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (canDraw) {
        for (UITouch *t in touches) {
            [currentLine setColor:drawColor];
            CGPoint loc = [t locationInView:self];
            [currentLine setEnd:loc];
            
            if (currentLine) {
                [self addLine:currentLine];
            }
            Line *newLine = [[Line alloc] init];
            [newLine setBegin:loc];
            [newLine setEnd:loc];
            [newLine setColor:drawColor];
            currentLine = newLine;
        }
        [self setNeedsDisplay];
    }
}

- (void)endTouches:(NSSet *)touches
{
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (canDraw) {
        [self endTouches:touches];
        [self.undoManager endUndoGrouping];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didMoveToWindow
{
    [self becomeFirstResponder];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFram");
    }
    return self;
}

- (void)initButton{
    linesCompleted = [[NSMutableArray alloc] init];
    canDraw = NO;
    drawColor = [UIColor blackColor];
    [self setMultipleTouchEnabled:YES];
    [self becomeFirstResponder];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)switchVisible{
    if (canDraw) {
        canDraw = NO;
    }else{
        canDraw = YES;
    }
    
}

@end