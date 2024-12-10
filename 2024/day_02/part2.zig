const std = @import("std");
const builtin = @import("builtin");
const print = std.debug.print;
const inputFile = @embedFile("input.txt");
const allocator = std.head.page_allocator;

const directions = enum { increasing, decreasing, undetermined };

pub fn main() !void {
    // parse the file for lines
    var lines = std.mem.tokenizeScalar(u8, inputFile, '\n');

    // initialize our counts
    var unsafeCount: i32 = 0;
    var totalCount: i32 = 0;

    while (lines.next()) |line| {
        // split to get an iterator for the line
        var splitLine = std.mem.tokenizeScalar(u8, line, ' ');

        // set the initial direction
        var direction: directions = directions.undetermined;

        // all lines are safe by default
        var isSafe: bool = true;

        var prev: i32 = try std.fmt.parseInt(i32, splitLine.next().?, 10);

        while (splitLine.next()) |num| {
            const curr = try std.fmt.parseInt(i32, num, 10);

            // first pass of a line the direction is undetermined
            if (direction == directions.undetermined) {
                if (curr > prev) {
                    direction = directions.increasing;
                } else if (curr < prev) {
                    direction = directions.decreasing;
                } else {
                    isSafe = false;
                    break;
                }
            }

            // check if the direction is maintained for this window
            const isIncreasing: bool = curr > prev;
            const isDecreasing: bool = curr < prev;

            const isWrongDirection: bool = (direction == directions.increasing and isDecreasing) or (direction == directions.decreasing and isIncreasing);

            if (!isDifferInRange(prev, curr) or isWrongDirection) {
                isSafe = false;
                break;
            }
            prev = curr;
        }
        totalCount += 1;
        if (!isSafe) unsafeCount += 1;
    }

    print("Total Lines: {d}\n", .{totalCount});
    print("Safe Lines: {d}\n", .{totalCount - unsafeCount});
    print("Unsafe Lines: {d}\n", .{unsafeCount});
}

pub fn isDifferInRange(a: i32, b: i32) bool {
    const differ: u32 = @abs(a - b);
    return (differ >= 1 and differ <= 3);
}
