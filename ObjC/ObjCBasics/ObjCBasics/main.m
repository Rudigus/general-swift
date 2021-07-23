// To compile this code, run this in terminal:
// gcc -framework Foundation Warrior.m main.m -o main

#import <Foundation/Foundation.h>
#import "Warrior.h"

// Shows many ways to print strings in objective-c alongside Foundation framework.
// char *string or const char *string - default C string
// NSString *string - immutable Foundation string
// NSMutableString *string - mutable Foundation string
void stringExample() {
    NSString *nsString = @"this is a NS string";
    char *cString = "this is a C string";
    printf("Default C printf usage. %s\n", cString);
    printf("%s UPPERCASED\n", [[nsString uppercaseString] UTF8String]);
    NSLog(@"%s\n", [nsString UTF8String]);
    printf("%s\n", [[[nsString stringByAppendingString:@" and "] stringByAppendingString:[NSString stringWithUTF8String:cString]] UTF8String]);
    NSLog(@"bugged: %s\n", nsString);
    NSLog(@"unbugged: %@\n", nsString);
}

// Messing with arrays in objective-c and Foundation
// NSArray *array - immutable Foundation array
// NSMutableArray *array - mutable Foundation array
// arrays in Foundation accept all types of objects (NSObjects)
// NSObject is the base class of objects in objective-c
// id is a language keyword which is also a data type and it might look similar to NSObject, but it is very different.
// Objects pointed by id don't have their types checked by the compiler, so it lets you use dynamic typing in objective-c
void arrayExample() {
    NSArray *array = @[@"the", @"ultimate", @"answer", @"is", @42];
    NSLog(@"array: %@", array);
    for (id genericObject in array) {
        NSLog(@"%@", genericObject);
    }
    // It compiles and runs without the type casting, but NSUInteger is not really interchangeable with int, since NSUInteger is basically a type alias of unsigned long in most Apple platforms. Therefore, it is advised to perform the cast.
    NSLog(@"%d", (int)[array count]);
}

// Using custom object
void warriorExample() {
    Warrior *firstWarrior = [[Warrior alloc] initWithName:@"Derek"];
    Warrior *secondWarrior = [[Warrior alloc] initWithName:@"Gustav"];
    [firstWarrior attackWarrior:secondWarrior];
    NSLog(@"%@", firstWarrior);
    NSLog(@"%@", secondWarrior);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        stringExample();
//        arrayExample();
        warriorExample();
    }
    return 0;
}
