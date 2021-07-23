//
//  Warrior.m
//  ObjCBasics
//
//  Created by Rudigus on 22/07/21.
//

#import "Warrior.h"

@implementation Warrior

// Convenience initializer
- (instancetype)init {
    self = [self initWithName:@"Unnamed Warrior"];
    return self;
}

// Designated initializer
- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.attack = 20;
        self.health = 100;
    }
    return self;
}

// Beautiful description for printing object with NSLog :D
- (NSString *)description {
    return [NSString stringWithFormat:@"Warrior %@ (Attack: %.2f, Health: %.2f)", self.name, self.attack, self.health];
}

- (float) attackWarrior:(Warrior *)warrior {
    warrior.health -= self.attack;
    return warrior.health;
}

@end
