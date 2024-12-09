const std = @import("std");
const builtin = @import("builtin");
const print = std.debug.print;
const inputFile = @embedFile("input.txt");
const allocator = std.head.page_allocator;

const lineEnding = if (builtin.os.tag == .windows) "\r\n" else "\n";

pub fn main() !void {
    // parse the file for lines
    var lines = std.mem.tokenizeScalar(u8, inputFile, '\n');

    // var safeCount: i32 = 0;
    // var isIncreasing: bool = undefined;

    while (lines.next()) |line| {
        const splitLine = std.mem.tokenizeScalar(u8, line, ' ');
        for (splitLine.buffer, 0..) |element, i| {
            print("buffer is {c}\n", .{splitLine.buffer[i]});
            _ = element;
        }
    }
}

pub fn isDifferInRange(a: i32, b: i32) bool {
    const differ: i32 = @abs(a - b);

    if (differ >= 1 and differ <= 3) return true;

    return false;
}

// splitLine is our parsed out line. We get the first
// if (splitLine.next()) |first| {
//     if (splitLine.next()) |second| {
//         const parsedFirst = try std.fmt.parseInt(i32, first, 10);
//         const parsedSecond = try std.fmt.parseInt(i32, second, 10);

// var max: i32 = std.math.minInt(i32);
// var min: i32 = std.math.maxInt(i32);

// by the time we reach these two if statement we know that
// the level are between 1 and 3 levels apart from eachother
// therefore we don't need a test case for equality
// if (parsedFirst < parsedSecond) {
//     isIncreasing = true;
//     max = parsedSecond;
// }
// else if (parsedFirst > parsedSecond) {
//     isIncreasing = false;
//     min = parsedSecond;
// }
// var isSafe: bool = undefined;
// while (splitLine.next()) |prev| {
//     const parsedPrev = try std.fmt.parseInt(i32, prev, 10);
//     const parsedCurr = std.fmt.parseInt(i32, splitLine.next(), 10) catch {
//         isSafe = false;
//         break;
//     };

//     if (isDifferInRange(parsedPrev, parsedCurr)) {
//         isSafe = false;
//         break;
//     }

//     if (isIncreasing) {
//         max = parsedPrev;
//         if ()
//     }
//     else {

//     }
// }
// if (isSafe) safeCount += 1;
// }
// const next = splitLine.next();
// const curr_data = try std.fmt.parseInt(i32, curr, 10);
// const next_data = try std.fmt.parseInt(i32, next, 10);

// // if curr_data is smaller than the next_data then isIncreasing is true
// isIncreasing = if (curr_data < next_data) true else false;

// if (isIncreasing) {

// } else {}

// // try levelsData.append();
// safeCount += 1;
// }
// }

// pub fn checkLevels(line: ?[] const u8) void {

// }
